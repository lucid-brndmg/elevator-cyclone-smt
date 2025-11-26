const {spawnSync} = require("node:child_process");
const path = require("node:path");
const liftgen = "liftblast.js"

const cyclone_native = "D:\\mu\\cyclone-tutorial\\analyzer-native\\cyclone-rs\\target\\debug\\cyclone-native.exe"
const cyclone_native_stack = 512 * 1024 * 1024

const to_sec = 2 * 60 * 60

const lia_solvers = [
  {id: "z3", h: (f, sfx = "") => `z3 ${f} -st -T:${to_sec} &>> out_z3${sfx}.txt\necho "fin ${f}" >> out_z3${sfx}.txt\n`},
  {id: "osmt", h: (f, sfx = "") => `echo "(set-logic QF_LIA)" > osmt${sfx}.smt2\ncat ${f} >> osmt${sfx}.smt2\n/usr/bin/time -ao out_osmt_time${sfx}.txt timeout ${to_sec} opensmt osmt${sfx}.smt2 &>> out_osmt${sfx}.txt \necho "fin ${f}" >> out_osmt${sfx}.txt\n`},
  {id: "y2", h: (f, sfx = "") => `echo "(set-logic QF_LIA)" > y2${sfx}.smt2\ncat ${f} >> y2${sfx}.smt2\nyices-smt2 -t ${to_sec} -s y2${sfx}.smt2 &>> out_y2${sfx}.txt\necho "fin ${f}" >> out_y2${sfx}.txt\n`},
  {id: "cvc5", h: (f, sfx = "") => `echo "(set-logic QF_LIA)" > c5${sfx}.smt2\ncat ${f} >> c5${sfx}.smt2\ncvc5 --stats --tlimit ${to_sec * 1000} c5${sfx}.smt2 &>> out_c5${sfx}.txt\necho "fin ${f}" >> out_c5${sfx}.txt\n`},
  {id: "ms", h: (f, sfx) => `echo "(set-logic QF_LIA)" > ms${sfx}.smt2\ncat ${f} >> ms${sfx}.smt2\ntimeout ${to_sec} mathsat -stats ms${sfx}.smt2 &>> out_ms${sfx}.txt\necho "fin ${f}" >> out_ms${sfx}.txt\n`}
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
  const args = [file_in, "--codegen", file_out, "--stack-size", cyclone_native_stack]
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

const numeric_parse = line => line.match(/([\d+\.]+)/)[0]

const filename_parse = name => {
  const dots = name.split(".")
  const is_cyclone_gen = dots.includes("cyclone_gen")
  const is_bv = dots.includes("bv")
  const conf = dots[0].split("_")
  const is_stc = conf.includes("stc")
  const prop = conf.includes("l01m0123")
    ? "AG"
    : conf.includes("l01") ? "FR" : "DS"
  const n = conf[0].slice(1)
  const k = !is_stc ? conf[conf.length - 1] : "0"
  return [
    is_stc ? "stc" : "dyn",
    n, k, prop,
    is_cyclone_gen ? "cy" : "cr",
    is_bv ? "bv" : "lia",
  ].join(".")
}

const TO = "7200"
// const non_existing = ["l10_stc_m0123.cyclone_gen.smt2", "l10_stc_l01m0123.cyclone_gen.smt2"]

const handle_fin = (results, line, time) => {
  if (line.startsWith("fin") && line.endsWith(".smt2")) {
    const filename = line.split(" ")[1]
    const key = filename_parse(filename)
    // const t = non_existing.includes(filename) ? TO : time
    results.push({
      key,
      time
    })
    return true
  }
  return false
}

const parse_stp = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith("CPU Time Used")) {
      time = numeric_parse(line)
    }
    if (hf(results, line, time)) {
      time = TO
    }
  }
  return results
}

const parse_z3 = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  let is_confirm_to = false
  for (let line of lines) {
    if (line === "timeout") {
      is_confirm_to = true
    }
    if (line.startsWith(":time")) {
      time = numeric_parse(line)
    }
    if (hf(results, line, time)) {
      if (is_confirm_to) {
        results[results.length - 1].time = TO
      }
      time = TO
      is_confirm_to = false
    }
  }
  return results
}

const parse_c5 = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith("global::totalTime")) {
      time = parseInt(numeric_parse(line))
      time = (time / 1000).toFixed(2)
    }
    if (hf(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_y2 = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith(":total-run-time")) {
      time = parseFloat(numeric_parse(line))
      time = time.toFixed(2)
    }
    if (hf(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_bwz = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith("solving_context::time_solve")) {
      time = parseInt(numeric_parse(line))
      time = (time / 1000).toFixed(2)
    }
    if (hf(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_ms = (lines, hf = handle_fin) => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith(":time-seconds")) {
      time = parseFloat(numeric_parse(line))
      time = time.toFixed(2)
    }
    if (hf(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_osmt = (lines, hf = handle_fin) => {
  const sep = ":time-sep:"
  const sep_idx = lines.findIndex(line => line === sep)
  const lines_fins = lines.slice(0, sep_idx)
  const lines_times = lines.slice(sep_idx + 1)
  const times = []
  for (let t of lines_times) {
    if (t.includes("user")) {
      times.push(numeric_parse(t.split(" ")[0]))
    }
  }
  const results = []
  let i = 0
  let is_result = false
  for (let line of lines_fins) {
    if (line === "unsat" || line === "sat") {
      is_result = true
    }
    if (hf(results, line, times[i])) {
      if (!is_result) {
        results[results.length - 1].time = TO
      }
      is_result = false
      i += 1
    }
  }
  return results
}

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
  gen_cyclone,
  parse_bwz,
  parse_stp,
  parse_osmt,
  parse_ms,
  parse_c5,
  parse_y2,
  parse_z3
}