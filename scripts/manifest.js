const liftgen = "liftblast.js"

const cyclone_native = "D:\\mu\\cyclone-tutorial\\analyzer-native\\cyclone-rs\\target\\debug\\cyclone-native.exe"

const to_sec = 2 * 60 * 60

const lia_solvers = [
  {id: "z3", h: (f, sfx = "") => `z3 ${f} -st -T:${to_sec} &>> out_z3${sfx}.txt\necho "fin ${f}" >> out_z3${sfx}.txt\n`},
]

const bv_solvers = [
  {id: "z3bv", h: (f, sfx = "") => `z3 ${f} -st -T:${to_sec} &>> out_z3bv${sfx}.txt\necho "fin ${f}" >> out_z3bv${sfx}.txt\n`},
  {id: "bitwuzla", h: (f, sfx = "") => `bitwuzla ${f} -v 1 -t ${to_sec * 1000} &>> out_bitwuzla${sfx}.txt\necho "fin ${f}" >> out_bitwuzla${sfx}.txt\n`},
  {id: "stp", h: (f, sfx = "") => `timeout ${to_sec} stp ${f} -t &>> out_stp${sfx}.txt\necho "fin ${f}" >> out_stp${sfx}.txt\n`}
]

// option-timeout currently isn't handled in cyclone-native thus coreutils timeout command do the trick (bit hack)
const cyclone = (f, sfx = "") => `timeout ${to_sec} cyclone ${f} &>> out_cyclone${sfx}.txt\necho "fin ${f}" >> out_cyclone${sfx}.txt\n`

const exec_opts = {
  encoding: "utf-8"
}

module.exports = {
  cyclone_native,
  to_sec,
  lia_solvers,
  bv_solvers,
  cyclone,
  liftgen,
  exec_opts
}