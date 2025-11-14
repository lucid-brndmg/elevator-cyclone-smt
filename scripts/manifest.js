const {spawnSync} = require("node:child_process");
const path = require("node:path");
const liftgen = "liftblast.js"

const cyclone_native = "D:\\mu\\cyclone-tutorial\\analyzer-native\\cyclone-rs\\target\\debug\\cyclone-native.exe"

const to_sec = 2 * 60 * 60

const lia_solvers = [
  {id: "z3", h: (f, sfx = "") => `z3 ${f} -st -T:${to_sec} &>> out_z3${sfx}.txt\necho "fin ${f}" >> out_z3${sfx}.txt\n`},
  {id: "osmt", h: (f, sfx = "") => `echo "(set-logic QF_LIA)" > osmt${sfx}.smt2\ncat ${f} >> osmt${sfx}.smt2\n/usr/bin/time -ao out_osmt_time${sfx}.txt timeout ${to_sec} opensmt osmt${sfx}.smt2 &>> out_osmt${sfx}.txt \necho "fin ${f}" >> out_osmt${sfx}.txt\n`},
  {id: "y2", h: (f, sfx = "") => `echo "(set-logic QF_LIA)" > y2${sfx}.smt2\ncat ${f} >> y2${sfx}.smt2\nyices-smt2 -t ${to_sec} -s y2${sfx}.smt2 &>> out_y2${sfx}.txt\necho "fin ${f}" >> out_y2${sfx}.txt\n`}
]

const bv_solvers = [
  {id: "z3bv", h: (f, sfx = "") => `z3 ${f} -st -T:${to_sec} &>> out_z3bv${sfx}.txt\necho "fin ${f}" >> out_z3bv${sfx}.txt\n`},
  {id: "bitwuzla", h: (f, sfx = "") => `bitwuzla ${f} -v 1 -t ${to_sec * 1000} &>> out_bitwuzla${sfx}.txt\necho "fin ${f}" >> out_bitwuzla${sfx}.txt\n`},
  {id: "stp", h: (f, sfx = "") => `timeout ${to_sec} stp ${f} -t &>> out_stp${sfx}.txt\necho "fin ${f}" >> out_stp${sfx}.txt\n`},
  {id: "y2bv", h: (f, sfx = "") => `echo "(set-logic QF_BV)" > y2bv${sfx}.smt2\ncat ${f} >> y2bv${sfx}.smt2\nyices-smt2 -t ${to_sec} -s y2bv${sfx}.smt2 &>> out_y2bv${sfx}.txt\necho "fin ${f}" >> out_y2bv${sfx}.txt\n`}
]

// option-timeout currently isn't handled in cyclone-native thus coreutils timeout command do the trick (bit hack)
const cyclone = (f, sfx = "") => `timeout ${to_sec} cyclone ${f} &>> out_cyclone${sfx}.txt\necho "fin ${f}" >> out_cyclone${sfx}.txt\n`

const exec_opts = {
  encoding: "utf-8"
}

const gen_cyclone = (conf) => spawnSync("node", [liftgen, JSON.stringify(conf)], exec_opts)

const compile_cyclone_native = (file_in, file_out, bv = 0) => {
  const args = [file_in, "--codegen", file_out]
  if (bv) {
    args.push("--option-bv-int", "--option-bv-int-size", bv)
  }

  return spawnSync(cyclone_native, args, exec_opts)
}

// const compile_cyclone = (file_in, out_dir) => {
//   const cwd = process.cwd();
//   process.chdir(out_dir)
//   const h = spawnSync("cyclone-gen", [file_in], exec_opts)
//   process.chdir(cwd)
//
//   return h
// }

module.exports = {
  cyclone_native,
  to_sec,
  lia_solvers,
  bv_solvers,
  cyclone,
  liftgen,
  exec_opts,
  compile_cyclone_native,
  // compile_cyclone,
  gen_cyclone
}