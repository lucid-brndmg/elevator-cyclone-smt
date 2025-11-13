const { spawnSync } = require('node:child_process');
const path = require("node:path")
const fs = require("fs")

const {
  cyclone_native,
  lia_solvers,
  bv_solvers,
  cyclone,
  liftgen,
  exec_opts
} = require("./manifest")

const outdir = path.resolve("../tmp_prop")

const codegen = true

// const sh_stc_cyclone = []
// const sh_stc_lia_solvers = lia_solvers.map(({id}) => ({id: id + "_stc", lines: []}))
// const sh_stc_bv_solvers = bv_solvers.map(({id}) => ({id: id + "_stc", lines: []}))
//
// const sh_dyn_cyclone = []
// const sh_dyn_lia_solvers = lia_solvers.map(({id}) => ({id: id + "_dyn", lines: []}))
// const sh_dyn_bv_solvers = bv_solvers.map(({id}) => ({id: id + "_dyn", lines: []}))

const sh_cyclone = {}
const sh_lia = {}
const sh_bv = {}

const ns = [3, 5, 10, 15]

const props = [
  // {initPropLH: [0]},
  // {initPropLH: [1]},
  {initPropLH: [0, 1]},

  // {initPropMS: [0]},
  // {initPropMS: [1]},
  // {initPropMS: [2]},
  // {initPropMS: [3]},
  {initPropMS: [0, 1, 2, 3]},

  {initPropLH: [0, 1], initPropMS: [0, 1, 2, 3]},
]

const propDef = {
  initPropHalt: [],
  initPropIdle: [],
  initPropLH: [],
  initPropMS: []
}

const def_id = def => {
  let s = ""
  if (def.initPropHalt == null || def.initPropHalt.length) {
    s += `h${def.initPropHalt?.join("")}`
  }
  if (def.initPropIdle == null || def.initPropIdle.length) {
    s += `i${def.initPropIdle?.join("")}`
  }
  if (def.initPropLH == null || def.initPropLH.length) {
    s += `l${def.initPropLH?.join("")}`
  }
  if (def.initPropMS == null || def.initPropMS.length) {
    s += `m${def.initPropMS?.join("")}`
  }
  return s
}

for (let prop of props) {
  const def = {...propDef, ...prop}
  const sfx = def_id(def)

  for (let n of ns) {
    const base_stc = `l${n}_stc_${sfx}.cyclone`
    const base_dyn = `l${n}_dyn_${sfx}.cyclone`

    const conf_stc = {
      optPropCheck: true,
      optPropAgg: true,
      optEffect: false,
      optDebug: false,
      optOut: path.join(outdir, base_stc),
      optN: n,
      ...def
    }

    const conf_dyn = {
      ...conf_stc,
      optOut: path.join(outdir, base_dyn),
      optEffect: true,
    }
    // k_max + 1 (sc) + 1 (signed)
    const bits = Math.ceil(Math.log2(8 * n + 2 + 1)) + 1

    for (let [base, conf] of [[base_stc, conf_stc], [base_dyn, conf_dyn]]) {
      const base_bv = `${base}.bv.smt2`
      const base_lia = `${base}.lia.smt2`

      if (codegen) {
        const h_gen = spawnSync("node", [liftgen, JSON.stringify(conf)], exec_opts)
        console.log("gen cyclone", h_gen);

        const h_cmp_lia = spawnSync(cyclone_native, [conf.optOut, "--codegen", path.join(outdir, base_lia)], exec_opts)
        console.log("gen lia", h_cmp_lia);

        const h_cmp_bv = spawnSync(cyclone_native, [conf.optOut, "--codegen", path.join(outdir, base_bv), "--option-bv-int", "--option-bv-int-size", bits], exec_opts)
        console.log("gen bv", h_cmp_bv);
      }



      if (!sh_cyclone[n]) {
        sh_cyclone[n] = {id: `cyclone_${n}`, lines: []}
      }
      if (!sh_lia[n]) {
        sh_lia[n] = lia_solvers.map(({id}) => ({id: `${id}_${n}`, lines: []}))
      }
      if (!sh_bv[n]) {
        sh_bv[n] = bv_solvers.map(({id}) => ({id: `${id}_${n}`, lines: []}))
      }

      const done = `echo "done ${base}"`

      sh_cyclone[n].lines.push(cyclone(base, n), done)
      sh_lia[n].forEach(({lines}, i) => lines.push(lia_solvers[i].h(base_lia, n), done))
      sh_bv[n].forEach(({lines}, i) => lines.push(bv_solvers[i].h(base_bv, n), done))


      // if (base.includes("stc")) {
      //   sh_stc_cyclone.push(cyclone(base, "stc"))
      //   sh_stc_lia_solvers.forEach(({id, lines}, i) => lines.push(lia_solvers[i].h(base_lia, "stc")))
      //   sh_stc_bv_solvers.forEach(({id, lines}, i) => lines.push(bv_solvers[i].h(base_bv, "stc")))
      // } else {
      //   sh_dyn_cyclone.push(cyclone(base, "dyn"))
      //   sh_dyn_lia_solvers.forEach(({id, lines}, i) => lines.push(lia_solvers[i].h(base_lia, "dyn")))
      //   sh_dyn_bv_solvers.forEach(({id, lines}, i) => lines.push(bv_solvers[i].h(base_bv, "dyn")))
      // }
    }
  }
}



// const agg = sh_stc_lia_solvers
//   .concat(sh_dyn_lia_solvers)
//   .concat(sh_stc_bv_solvers)
//   .concat(sh_dyn_bv_solvers)
//   .concat([{id: "cyclone_stc", lines: sh_stc_cyclone}, {id: "cyclone_dyn", lines: sh_dyn_cyclone}])

const agg = Object.values(sh_cyclone)
  .concat(Object.values(sh_lia).flat())
  .concat(Object.values(sh_bv).flat())


for (let {id, lines} of agg) {
  fs.writeFileSync(path.join(outdir, `exec_${id}.sh`), lines.join("\n"), "utf8")
}

console.log("done");