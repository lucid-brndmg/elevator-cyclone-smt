const path = require("node:path")
const fs = require("fs")

const {
  lia_solvers,
  bv_solvers,
  gen_cyclone,
  compile_cyclone_native,
} = require("./manifest")

const outdir = path.resolve("../../tmp_exec")

const codegen = true

// const sh_cyclone = {}
const sh_lia = {}
const sh_bv = {}
const sh_gen_cyclone = {id: "cyclone_smt2", lines: []}

const gen_static = false
const gen_dynamic = true

const gen_lia = false
const gen_bv = true

const ns = [3, 5, 10, 15]
const ks = [4, 8, 16, 32]

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

const bc = []

for (let prop of props) {
  const def = {...propDef, ...prop}
  const sfx = def_id(def)

  for (let n of ns) {
    const base_stc = `l${n}_stc_${sfx}`
    const base_dyn = `l${n}_dyn_${sfx}`

    if (gen_static) {
      const base = `${base_stc}.cyclone`
      const conf_stc = {
        optPropCheck: true,
        optPropAgg: true,
        optEffect: false,
        optDebug: false,
        optOut: path.join(outdir, base),
        optN: n,
        ...def
      }
      bc.push([base, n, conf_stc])
    }



    if (gen_dynamic && sfx.includes("l") && sfx.includes("m")) {
      for (let k of ks) {
        const base = `${base_dyn}_${k}.cyclone`
        const conf_dyn = {
          optPropCheck: true,
          optPropAgg: true,
          optDebug: false,
          optN: n,
          optOut: path.join(outdir, base),
          optEffect: true,
          optK: k,
          ...def
        }
        bc.push([base, n, conf_dyn])
      }
    }


    // k_max + 1 (sc) + 1 (signed)
  }
}

for (let [base, sep, conf] of bc) {
  const bits = Math.max(
    conf.optK ? (Math.ceil(Math.log2(conf.optK)) + 1) : (Math.ceil(Math.log2(8 * conf.optN + 2 + 1)) + 1),
    Math.ceil(Math.log2(conf.optN)) + 1
  )
  const base_bv = `${base}.bv.smt2`
  const base_lia = `${base}.lia.smt2`
  const base_lia_cyclone = `${base}_gen.smt2`

  if (codegen) {
    const h_gen = gen_cyclone(conf)
    console.log("gen cyclone", h_gen);

    if (gen_lia) {
      // conf.optOut path.join(outdir, base_lia)
      const h_cmp_lia = compile_cyclone_native(conf.optOut, path.join(outdir, base_lia))
      console.log("gen lia", h_cmp_lia);
    }

    if (gen_bv) {
      const h_cmp_bv = compile_cyclone_native(conf.optOut, path.join(outdir, base_bv), bits)
      console.log("gen bv", h_cmp_bv);
    }
  }

  sh_gen_cyclone.lines.push(`cyclone-gen ${base}`)

  // if (!sh_cyclone[n]) {
  //   sh_cyclone[n] = {id: `cyclone_${n}`, lines: []}
  // }
  if (!sh_lia[sep]) {
    sh_lia[sep] = lia_solvers.map(({id}) => ({id: `${id}_${sep}`, lines: []}))
  }
  if (!sh_bv[sep]) {
    sh_bv[sep] = bv_solvers.map(({id}) => ({id: `${id}_${sep}`, lines: []}))
  }

  // const done = `echo "done ${base}"`

  // sh_cyclone[n].lines.push(cyclone(base, n), done)
  sh_lia[sep].forEach(({lines}, i) => lines.push(
    lia_solvers[i].h(base_lia, sep),
    `echo "done ${base_lia}"`,
    lia_solvers[i].h(base_lia_cyclone, sep),
    `echo "done ${base_lia_cyclone}"`
  ))
  sh_bv[sep].forEach(({lines}, i) => lines.push(
    bv_solvers[i].h(base_bv, sep),
    `echo "done ${base_bv}"`
  ))


}

const agg = Object.values(sh_lia).flat()
  .concat(Object.values(sh_bv).flat())
  .concat([sh_gen_cyclone])


for (let {id, lines} of agg) {
  fs.writeFileSync(path.join(outdir, `exec_${id}.sh`), lines.sort((a, b) => (b.includes("dyn") - a.includes("dyn"))).join("\n"), "utf8")
}

console.log("done");