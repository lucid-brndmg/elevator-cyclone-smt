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

const outdir = path.resolve("../prop")

const sh_stc_cyclone = []
const sh_stc_lia_solvers = lia_solvers.map(({id}) => ({id: id + "_stc", lines: []}))
const sh_stc_bv_solvers = bv_solvers.map(({id}) => ({id: id + "_stc", lines: []}))

const sh_dyn_cyclone = []
const sh_dyn_lia_solvers = lia_solvers.map(({id}) => ({id: id + "_dyn", lines: []}))
const sh_dyn_bv_solvers = bv_solvers.map(({id}) => ({id: id + "_dyn", lines: []}))


const ns = [3, 5, 10, 15, 20]

for (let n of ns) {
  const base_stc = `l${n}_stc.cyclone`
  const base_dyn = `l${n}_dyn.cyclone`

  const conf_stc = {
    optPropCheck: true,
    optPropAgg: true,
    optEffect: false,
    optDebug: false,
    optOut: path.join(outdir, base_stc),
    optN: n,
  }

  const conf_dyn = {
    ...conf_stc,
    optOut: path.join(outdir, base_dyn),
    optEffect: true,
  }
  // k_max + 1 (sc) + 1 (signed)
  const bits = Math.ceil(Math.log2(8 * n + 2 + 1)) + 1
  
  for (let [base, conf] of [[base_stc, conf_stc], [base_dyn, conf_dyn]]) {
    const h_gen = spawnSync("node", [liftgen, JSON.stringify(conf)], exec_opts)
    console.log("gen cyclone", h_gen);

    const base_bv = `${base}.bv.smt2`
    const base_lia = `${base}.lia.smt2`
    
    const h_cmp_lia = spawnSync(cyclone_native, [conf.optOut, "--codegen", path.join(outdir, base_lia)], exec_opts)
    console.log("gen lia", h_cmp_lia);
      
    const h_cmp_bv = spawnSync(cyclone_native, [conf.optOut, "--codegen", path.join(outdir, base_bv), "--option-bv-int", "--option-bv-int-size", bits], exec_opts)
    console.log("gen bv", h_cmp_bv);

    if (base.includes("stc")) {
      sh_stc_cyclone.push(cyclone(base, "stc"))
      sh_stc_lia_solvers.forEach(({id, lines}, i) => lines.push(lia_solvers[i].h(base_lia, "stc")))
      sh_stc_bv_solvers.forEach(({id, lines}, i) => lines.push(bv_solvers[i].h(base_bv, "stc")))
    } else {
      sh_dyn_cyclone.push(cyclone(base, "dyn"))
      sh_dyn_lia_solvers.forEach(({id, lines}, i) => lines.push(lia_solvers[i].h(base_lia, "dyn")))
      sh_dyn_bv_solvers.forEach(({id, lines}, i) => lines.push(bv_solvers[i].h(base_bv, "dyn")))
    }
  }
}

const agg = sh_stc_lia_solvers
  .concat(sh_dyn_lia_solvers)
  .concat(sh_stc_bv_solvers)
  .concat(sh_dyn_bv_solvers)
  .concat([{id: "cyclone_stc", lines: sh_stc_cyclone}, {id: "cyclone_dyn", lines: sh_dyn_cyclone}])

for (let {id, lines} of agg) {
  fs.writeFileSync(path.join(outdir, `exec_${id}.sh`), lines.join("\n"), "utf8")
}

console.log("done");