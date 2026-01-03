const fs = require("fs")
const path = require("path")

const numeric_parse = line => line.match(/([\d+\.]+)/)[0]

const filename_parse = name => {
  const dots = name.split(".")
  const is_cyclone_gen = dots.includes("cyclone_gen")
  const is_bv = dots.includes("bv")
  const conf = dots[0].split("_")
  const is_stc = conf.includes("stc")
  const prop = conf.includes("l01m0123") 
    ? "ALL" 
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

const parse_stp = lines => {
  const results = []
  let time = TO
  for (let line of lines) {  
    if (line.startsWith("CPU Time Used")) {
      time = numeric_parse(line)
    }
    if (handle_fin(results, line, time)) {
      time = TO
    }
  }
  return results
}

const parse_z3 = lines => {
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
    if (handle_fin(results, line, time)) {
      if (is_confirm_to) {
        results[results.length - 1].time = TO
      }
      time = TO
      is_confirm_to = false
    }
  }
  return results
}

const parse_c5 = lines => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith("global::totalTime")) {
      time = parseInt(numeric_parse(line))
      time = (time / 1000).toFixed(2)
    }
    if (handle_fin(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_y2 = lines => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith(":total-run-time")) {
      time = parseFloat(numeric_parse(line))
      time = time.toFixed(2)
    }
    if (handle_fin(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_bwz = lines => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith("solving_context::time_solve")) {
      time = parseInt(numeric_parse(line))
      time = (time / 1000).toFixed(2)
    }
    if (handle_fin(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_ms = lines => {
  const results = []
  let time = TO
  for (let line of lines) {
    if (line.startsWith(":time-seconds")) {
      time = parseFloat(numeric_parse(line))
      time = time.toFixed(2)
    }
    if (handle_fin(results, line, time)) {
      time = TO
    }
  }

  return results
}

const parse_osmt = lines => {
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
    if (handle_fin(results, line, times[i])) {
      if (!is_result) {
        results[results.length - 1].time = TO
      }
      is_result = false
      i += 1
    }
  }
  return results
}

const dir_in = "."

const solvers = [
  ["z3", parse_z3],
  ["z3bv", parse_z3],
  
  ["y2", parse_y2],
  ["y2bv", parse_y2],

  ["c5", parse_c5],
  ["stp", parse_stp],
  ["bitwuzla", parse_bwz],

  ["osmt", parse_osmt],
  ["ms", parse_ms],
].sort(([a], [b]) => b.length - a.length)

const solver_names = {
  "z3": "z3",
  "z3bv": "z3",
  "y2": "yices2",
  "y2bv": "yices2",
  "c5": "cvc5",
  "stp": "stp",
  "bitwuzla": "bitwuzla",
  "osmt": "opensmt",
  "ms": "mathsat"
}

const results = {}

fs.readdirSync(dir_in)
  .filter(f => f.startsWith("out_") && f.endsWith(".txt") && !f.includes("time"))
  .map(f => [f.slice(0, f.length - ".txt".length), fs.readFileSync(path.join(dir_in, f), "utf8").split("\n").map(it => it.trim())])
  .forEach(([filename, raw_lines]) => {
    const parts = filename.split("_")[1]
    const entry = solvers.find(([s]) => parts.startsWith(s))
    if (!entry) {
      console.log("skip", parts);
      return
    }
    const [id, parse] = entry
    const suff = parts.slice(id.length)
    
    let lines = raw_lines
    if (id === "osmt") {
      const lines_time = fs
        .readFileSync(path.join(dir_in, `out_osmt_time${suff}.txt`), "utf8")
        .split("\n")
        .map(it => it.trim())
      lines = [...lines, ":time-sep:", ...lines_time]
    }
    const xs = parse(lines)
    for (let {key, time} of xs) {
      const full_key = `${id}.${key}`
      const item = {time, id: full_key}
      // if (results[full_key]) {
      //   console.log("overwrite", results[full_key], item);
      // }
      results[full_key] = item
    }
  })

const data = Object.values(results)// .sort((a, b) => a.id.localeCompare(b.id))
const csv = []

for (let {time, id} of data) {
  const [solver_id, stc, n, k, prop, cy, enc] = id.split(".")
  csv.push(`${solver_names[solver_id]},${enc === "lia" ? "int" : "bv"},${cy === "cy" ? "cyclone-java" : "cyclone-rust"},${stc === "stc" ? "fixed" : "dynamic"},${n},${stc === "stc" ? "-" : k},${prop},${time >= 7200 ? "TO" : time}`)
}

const csv_txt = `solver,encoding,cyclone-version,config-type,floors,steps,property,time\n${csv.join("\n")}`

fs.writeFileSync("time.csv", csv_txt, "utf-8")