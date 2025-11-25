const { spawnSync } = require('node:child_process');
const path = require("node:path")
const fs = require("fs")

const {
  cyclone_native,
  lia_solvers,
  bv_solvers,
  cyclone,
  liftgen,
  exec_opts, gen_cyclone, compile_cyclone_native
} = require("./manifest")

const U = "U"
const D = "D"
const I = "I"

const outdir = path.join("../../cases")

const range = (lo, hi) => new Array(hi - lo).fill().map((_, i) => i + lo)

const path_gen_det = (conf) => {
  const [n, c, u, d, init_f, init_mode] = conf
  if (init_mode === I) {
    const p1 = path_gen_det([n, c, u, d, init_f, U])
    const p2 = path_gen_det([n, c, u, d, init_f, D])

    return Math.max(p1, p2)
  }

  let p = []
  let m = init_mode
  const sc = new Set(c)
  const su = new Set(u)
  const sd = new Set(d)
  let f = init_f

  while (m !== I || su.size || sc.size || sd.size) {
    const all = [...su, ...sd, ...sc]
    if (m === U && su.has(f) || m === D && sd.has(f) || sc.has(f)) {
      p.push(`L${f}`)
      if (m === U) su.delete(f)
      if (m === D) sd.delete(f)
      sc.delete(f)
    } else if (m === U && !sc.has(f) && !su.has(f) && all.some(x => x > f)) {
      f += 1
      p.push("MoveUp")
    } else if (m === D && !sc.has(f) && !sd.has(f) && all.some(x => x < f)) {
      f -= 1
      p.push("MoveDown")
    } else if (m !== U && ((m === I && sc.has(f)) || su.has(f) || all.some(j => j > f)) && (m === D && !sc.has(f) && !sd.has(f) && !all.some(x => x < f) || m !== D)) {
      m = U
      p.push(`SetMotionUp`)
    } else if (m !== D && ((m === I && sc.has(f)) || sd.has(f) || all.some(j => j < f)) && (m === U && !sc.has(f) && !su.has(f) && !all.some(x => x > f) || m !== U)) {
      m = D
      p.push("SetMotionDown")
    } else if (m !== I && all.length === 0) {
      m = I
      p.push("SetIdle")
    } else {
      console.log("WARN: unexpected state", sc, su, sd, f, m);
    }
  }

  console.log(p.map(s => `D->${s}`).join("->") + "->D");
  return p.length * 2
}

const configs = [
  // n, c, u, d, f, m
  [20, [10, 15, 18], [18], [], 12, U],
  [20, [5], [18], [], 19, D],
  [30, range(10, 30), range(9, 29), range(10, 30), 9, U],
  [30, [], [28], [25], 26, I],
  [30, [10, 20, 25], [], [11], 22, D],
  [35, range(0, 12), range(8, 16), [], 0, U],
  // [40, [20, 23, 1, 8, 15], range(0, 5).concat(range(20, 30)), [8, 20, 32], 36, D],
  [40, [30, 33, 27, 28, 21], range(25, 30), [28, 35, 32], 24, D],
  [45, [44], range(35, 40), range(34, 40), 42, U],
  [50, range(33, 41), range(37, 40), range(36, 41), 35, D],
  // [50, [49], [], range(40, 45), 30, U],
  [50, [49], [], range(38, 45), 42, U]
]
// const configs = JSON.parse(fs.readFileSync("../../rand_cases.json", "utf8"))

console.log(configs.length, "configurations");

const codegen = false
const pfx = "s"

const invalid = configs.find(xs => xs.length !== 6)
if (invalid) {
  console.log("invalid config", invalid);
  process.exit(0)
}

const bc = []
for (let i = 0; i < configs.length; i++) {
  const base_a = `${pfx}${i+1}_a.cyclone`
  const base_b = `${pfx}${i+1}_b.cyclone`
  const [n, lc, lu, ld, f, m] = configs[i]
  const k = path_gen_det(configs[i])
  console.log(`s${i + 1}: `, k)

  const def = {
    optPropCheck: false,
    optDebug: false,
    optN: n,
    optK: k, // 8 * n + 2,
    initFloor: f,
    initMode: m,
    initReqCar: lc,
    initReqUp: lu,
    initReqDown: ld,
  }

  const def_a = {
    optOut: path.join(outdir, base_a),
    optEffect: false,
    ...def,
  }

  const def_b = {
    optOut: path.join(outdir, base_b),
    optEffect: true,
    optTestValidation: "path",
    ...def
  }

  bc.push([base_a, def_a], [base_b, def_b])
}

// const sh_cyclone = []
const sh_lia_solvers = lia_solvers.map(({id}) => ({id, lines: []}))
const sh_bv_solvers = bv_solvers.map(({id}) => ({id, lines: []}))
const sh_gen_cyclone = {id: "cyclone_smt2", lines: []}

for (let [base, conf] of bc) {
  const bits = Math.ceil(Math.log2(conf.optN)) + 1
  const base_bv = `${base}.bv.smt2`
  const base_lia = `${base}.lia.smt2`
  const base_lia_cyclone = `${base}_gen.smt2`

  sh_gen_cyclone.lines.push(`cyclone-gen ${base}`)

  const h_gen = gen_cyclone(conf)
  console.log(h_gen)

  if (codegen) {
    const h_cmp_lia = compile_cyclone_native(conf.optOut, path.join(outdir, base_lia))
    console.log("gen lia", h_cmp_lia);

    const h_cmp_bv = compile_cyclone_native(conf.optOut, path.join(outdir, base_bv), bits)
    console.log("gen bv", h_cmp_bv);
  }

  sh_lia_solvers.forEach(({lines}, i) => lines.push(
    lia_solvers[i].h(base_lia),
    `echo "done ${base_lia}"`,
    lia_solvers[i].h(base_lia_cyclone),
    `echo "done ${base_lia_cyclone}"`
  ))

  sh_bv_solvers.forEach(({lines}, i) => lines.push(
    bv_solvers[i].h(base_bv),
    `echo "done ${base_bv}"`,
  ))


  // let [n, lc, lu, ld, f, m] = configs[i]
  // const base = `s${i + 1}.cyclone`
  // const optOut = path.join(outdir, base)
  // const conf = {
  //   optPropCheck: false,
  //   optEffect: false,
  //   optDebug: false,
  //   optOut,
  //   optN: n,
  //
  //   initFloor: f,
  //   initMode: m,
  //   initReqCar: lc,
  //   initReqUp: lu,
  //   initReqDown: ld,
  // }
  //
  // const h_gen = spawnSync("node", [liftgen, JSON.stringify(conf)], exec_opts)
  // console.log("gen cyclone", h_gen);
  //
  // const bits = Math.ceil(Math.log2(n)) + 1
  // const base_bv = `s${i+1}.cyclone.bv.smt2`
  // const base_lia = `s${i+1}.cyclone.lia.smt2`
  // const smt_bv = path.join(outdir, base_bv)
  // const smt_lia = path.join(outdir, base_lia)
  //
  // const h_cmp_lia = spawnSync(cyclone_native, [optOut, "--codegen", smt_lia], exec_opts)
  // console.log("gen lia", h_cmp_lia);
  //
  // const h_cmp_bv = spawnSync(cyclone_native, [optOut, "--codegen", smt_bv, "--option-bv-int", "--option-bv-int-size", bits], exec_opts)
  // console.log("gen bv", h_cmp_bv);
  //
  // // sh_cyclone.push(cyclone(base))
  // sh_lia_solvers.forEach(({id, lines}, i) => lines.push(lia_solvers[i].h(base_lia)))
  // sh_bv_solvers.forEach(({id, lines}, i) => lines.push(bv_solvers[i].h(base_bv)))
  //
  // console.log("gen done", i + 1);
}

for (let {id, lines} of sh_lia_solvers.concat(sh_bv_solvers).concat([sh_gen_cyclone])) {
  fs.writeFileSync(path.join(outdir, `exec_${id}.sh`), lines.join("\n"), "utf8")
}

console.log("done");