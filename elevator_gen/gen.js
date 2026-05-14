const fs = require("fs")

const tvOff = "off"
const tvPath = "path"

let optN = 3
let optK = 0
let optEffect = false
let optDebug = false
let optPropCheck = true
// let optPropAgg = true
let optOut = null
let optTestValidation = tvOff

const mUp = "U"
const mDown = "D"
const mIdle = "I"

let initFloor = 1
let initMode = mIdle
let initReqCar = [0, 1, 2]
let initReqUp = [0, 1]
let initReqDown = [1, 2]

let initPropLH = null // [0, 1]
let initPropMS = null // [0, 1, 2, 3] // 0, 1, 2 (U, D), 3 (U, D)

const input = (process.argv[2] ?? "").trim()
if (input) {
  const n = parseInt(input)
  if (n) {
    optN = n
  } else if (input.length) {
    try {
      const conf = JSON.parse(input)
      if (conf.initFloor != null) initFloor = conf.initFloor
      if (conf.initMode != null) initMode = conf.initMode
      if (conf.initReqCar != null) initReqCar = conf.initReqCar
      if (conf.initReqUp != null) initReqUp = conf.initReqUp
      if (conf.initReqDown != null) initReqDown = conf.initReqDown
      if (conf.optN != null) optN = conf.optN
      if (conf.optK != null) optK = conf.optK
      if (conf.optDebug != null) optDebug = conf.optDebug
      if (conf.optPropCheck != null) optPropCheck = conf.optPropCheck
      // if (conf.optPropAgg != null) optPropAgg = conf.optPropAgg
      if (conf.optEffect != null) optEffect = conf.optEffect
      if (conf.optOut != null) optOut = conf.optOut
      if (conf.optTestValidation != null) optTestValidation = conf.optTestValidation
      // if (conf.initPropHalt != null) initPropHalt = conf.initPropHalt
      // if (conf.initPropIdle != null) initPropIdle = conf.initPropIdle
      if (conf.initPropFR != null) initPropLH = conf.initPropFR
      if (conf.initPropDS != null) initPropMS = conf.initPropDS


    } catch (e) {
      console.log("Invalid JSON config input:", input);
      process.exit(0)
    }
  }
}

optOut ??= `lift_${optEffect ? "dyn" : "stc"}_${optN}.cyclone`

if (optN < 3) {
  console.log("please use stairs (n < 3)")
  process.exit(0)
}

const isTestValidation = optTestValidation !== tvOff

if (optPropCheck && isTestValidation) {
  console.log("property check OR test validation only");
  process.exit(0)
}



console.log("floors:", optN);
console.log("steps:", optK);
console.log("debug:", optDebug);
console.log("effect:", optEffect);
console.log("property check:", optPropCheck);
// console.log("property aggregation:", optPropAgg);
console.log("test validation:", optTestValidation);


const kMax = 8 * optN + 2

if (!optEffect) {
  console.log("k max:", kMax);
}

// else if (optPropCheck) {
//   console.log("unable to specify properties in effect mode");
//   process.exit(0)
// }

const fMax = optN - 1

const vReqUp = `l_u`
const vReqDown = `l_d`
const vReqCar = `l_c`
const vMode = `m`
const vFloor = `f`

const vEffUp = `r_u`
const vEffDown = `r_d`
const vEffCar = `r_c`
const vAccUp = `a_u`
const vAccDown = `a_d`
const vAccCar = `a_c`
const vSwUp = `s_u`
const vSwDown = `s_d`
const vSwCar = `s_c`
const vHandle = `h`

// const vFloorPrev = `f_prev`
const vFloorSD = `f_sw_d`
const vFloorSU = `f_sw_u`
const vModePrev = `m_prev`

const stSwitchIdle = "SetIdle"
const stSwitchDown = "SetMotionDown"
const stSwitchUp = "SetMotionUp"
const stFloorHandle = "L"
const stFloorIncr = "MoveUp"
const stFloorDecr = "MoveDown"
const stFloorDispatch = "D"
// const stEffect = "E"

const rangeN = new Array(optN).fill(undefined).map((_, i) => i)

const isDown = s => [vEffDown, vReqDown, vAccDown, vSwDown].includes(s)
const isUp = s => [vEffUp, vReqUp, vAccUp, vSwUp].includes(s)

const pfReq = `l`
const pfEff = `r`
const pfAcc = `a`
const pfSw = `s`

const pfReplace = (v, pf) => {
  const ys = v.split("_")
  ys[0] = pf
  return ys.join("_")
}

const setBlast = (sets, lo, hi) => sets.map(s => {
  const sliceRange = isDown(s)
    ? [1]
    : isUp(s)
      ? [0, rangeN.length - 1]
      : []
  return rangeN
    .slice(...sliceRange)
    .filter(i => (lo == null || i >= lo) && (hi == null || i < hi))
    .map(i => `${s}_${i}`)
}).flat()

const setSelect = (sets, i) => sets
  .filter(s => !((isDown(s) && i === 0) || (isUp(s) && i === fMax)))
  .map(s => `${s}_${i}`)

const setIsEmpty = (sets) => setBlast(sets).map(e => `!${e}`).join(" && ")

// Index pattern
const floorIActive = (sets, i) => setSelect(sets, i).join(" || ")

const currentFloorActive = (sets) => rangeN.map(i => {
  const e0 = floorIActive(sets, i)
  if (!e0.length) {
    return null
  }
  return `(${vFloor} == ${i}) && (${floorIActive(sets, i)})`
}).filter(it => it).join(" || ")

// todo: path-invariant by bitset bv(k) p = p | 0..1..0

// Slice pattern
const floorsSliceNotEmpty = (sets, isAbove) => rangeN
  .map(i => {
    const interval = isAbove ? [i + 1, optN] : [0, i]
    const v = setBlast(sets, ...interval)
    // const vc = setBlast(sets, ...(isAbove ? [0, i + 1] : [i, optN]))
    const xs = [
      `(${vFloor} == ${i})`
    ]

    if (v.length) {
      xs.push(`(${v.join(" || ")})`)
    } else {
      return null
    }

    return xs.join(" && ") // `(${vFloor} == ${i}) && ${v}`
  })
  .filter(it => it != null) // HACK!
  .join(" || ")

const floorsSliceSwitch = (isSwitchUp) => {
  const s = [vReqUp, vReqDown, vReqCar]
  // const sc = isSwitchUp ? vReqUp : vReqDown
  const m = isSwitchUp ? mDown : mUp

  return rangeN
    .map(i => {
      const interval = isSwitchUp ? [0, i] : [i + 1, optN]
      const intervalInv = isSwitchUp ? [i + 1, optN] : [0, i]
      const current = setSelect(isSwitchUp ? [vReqUp] : [vReqDown], i)
      const currentOpp = setSelect(isSwitchUp ? [vReqDown] : [vReqUp], i)

      const nonIdleEmpty = setBlast(s, ...interval)
        .concat(currentOpp)
        .concat([`${vReqCar}_${i}`])
      // const vc = setBlast(sets, ...(isAbove ? [0, i + 1] : [i, optN]))
      const xs = [
        `(${vFloor} == ${i})`,
        // `!${vReqCar}_${i}`
      ]

      if (nonIdleEmpty.length) {
        xs.push(`((${isMode(m)} && ${nonIdleEmpty.map(x => `!${x}`).join(" && ")}) || ${isMode(mIdle)})`)
      } else {
        xs.push(`(${isMode(m)} || ${isMode(mIdle)})`)
      }

      const nonEmpty = setBlast(s, ...intervalInv)
        .concat(current)
      // .concat([`${vReqCar}_${i}`])


      if (nonEmpty.length) {
        xs.push(`(${nonEmpty.join(" || ")} || (${isMode(mIdle)} && ${vReqCar}_${i}))`)
      } else {
        return null
      }

      return xs.join(" && ") // `(${vFloor} == ${i}) && ${v}`
    })
    .filter(it => it != null) // HACK!
    .join(" || ")
}

const isMode = m => `${vMode} == ${m}`

const mkState = (id, _stmt, _mods) => {
  const stmt = [...(_stmt ?? [])]
  const mods = [...(_mods ?? [])]
  return `${stmt.length ? "normal " : ""}${mods.length ? mods.join(" ") + " " : ""}state ${id} {${stmt.map(s => s.endsWith(";") ? s : s + ";").join(" ")}}`
}

const mkEdge = (s, t, c) => `edge {${s} -> ${t}${c ? ` where ${c};` : ""}}`

let stmtSwitchUp = [`${vMode} = ${mUp}`]
let stmtSwitchDown = [`${vMode} = ${mDown}`]
let stmtSwitchIdle = [`${vMode} = ${mIdle}`]

if (optPropCheck) {
  stmtSwitchUp.push(`${vFloorSU} = ${vFloor}`)
  stmtSwitchDown.push(`${vFloorSD} = ${vFloor}`)
  stmtSwitchIdle.push(`${vFloorSU} = ${vFloor}`, `${vFloorSD} = ${vFloor}`)
  const stmt = [
    `${vModePrev} = ${vMode}`
  ]

  if (optEffect) {
    for (let i of rangeN) {
      stmt.push(...setSelect([vReqUp, vReqDown, vReqCar], i).map(v => `${pfReplace(v, pfSw)} = ${v}`))
    }
  }

  stmtSwitchUp = stmt.concat(stmtSwitchUp)
  stmtSwitchDown = stmt.concat(stmtSwitchDown)
  stmtSwitchIdle = stmt.concat(stmtSwitchIdle)
}

const specStateSwitchIdle = mkState(stSwitchIdle, stmtSwitchIdle)
const specStateSwitchUp = mkState(stSwitchUp, stmtSwitchUp)
const specStateSwitchDown = mkState(stSwitchDown, stmtSwitchDown)

const specStateFloorIncr = mkState(stFloorIncr, [`${vFloor} += 1`])
const specStateFloorDecr = mkState(stFloorDecr, [`${vFloor} -= 1`])

const floorHandleStates = rangeN
  .map(i => {
    const xs = [
      `${vReqCar}_${i} = false`
    ]
    if (optEffect && optPropCheck) {
      xs.push(`${vSwCar}_${i} = false`)
    }
    if (optPropCheck) {
      xs.push(`${vHandle}_${i} = true`)
    }
    if (i !== fMax) {
      xs.push(`${vReqUp}_${i} = ${vReqUp}_${i} && !(${isMode(mUp)})`)
      if (optEffect && optPropCheck) {
        xs.push(`${vSwUp}_${i} = ${vSwUp}_${i} && !(${isMode(mUp)})`)
      }
    }
    if (i !== 0) {
      xs.push(`${vReqDown}_${i} = ${vReqDown}_${i} && !(${isMode(mDown)})`)
      if (optEffect && optPropCheck) {
        xs.push(`${vSwDown}_${i} = ${vSwDown}_${i} && !(${isMode(mDown)})`)
      }
    }
    return [
      `${stFloorHandle}${i}`,
      xs
    ]
  })

const states = [
  stFloorIncr,
  stFloorDecr,
  stFloorDispatch,
  stSwitchUp,
  stSwitchDown,
  stSwitchIdle,
  // ...(optEffect ? [stEffect] : []),
  ...rangeN.map(i => `${stFloorHandle}${i}`),
]

const modeBound = m => `${m} == ${mUp} || ${m} == ${mDown} || ${m} == ${mIdle}`

const varDecl = [
  `const int ${mUp} = 0;`,
  `const int ${mDown} = 1;`,
  `const int ${mIdle} = 2;`,

  `int ${vMode} where ${modeBound(vMode)} ${optPropCheck ? `, ${vModePrev} = ${vMode} where ${modeBound(vModePrev)}` : ""};`,
  `bool ${setBlast([vReqCar, vReqUp, vReqDown]).join(", ")};`,
  `int ${vFloor} where ${vFloor} >= 0 && ${vFloor} <= ${fMax};`
]

if (optPropCheck) {
  // varDecl.push(`int sc = 0, ${states.map(s => `sc_${s} = 0`).join(", ")};`)
  varDecl.push(`bool ${rangeN.map(i => `${vHandle}_${i} = false`).join(", ")};`)
  varDecl.push(`int ${vFloorSU} = ${vFloor} where ${vFloorSU} >= 0 && ${vFloorSU} <= ${fMax};`)
  varDecl.push(`int ${vFloorSD} = ${vFloor} where ${vFloorSD} >= 0 && ${vFloorSD} <= ${fMax};`)
}

const stateDecl = [
  specStateSwitchIdle,
  specStateSwitchUp,
  specStateSwitchDown,
  // specStateFloorDispatch,
  specStateFloorDecr,
  specStateFloorIncr,
  ...floorHandleStates.map(([s, e]) => mkState(s, e))
]


const edgeDecl = [
  mkEdge(stFloorDispatch, stFloorIncr, `${isMode(mUp)} && !(${currentFloorActive([vReqUp, vReqCar])}) && (${floorsSliceNotEmpty([vReqUp, vReqDown, vReqCar], true)})`),

  mkEdge(stFloorDispatch, stFloorDecr, `${isMode(mDown)} && !(${currentFloorActive([vReqDown, vReqCar])}) && (${floorsSliceNotEmpty([vReqUp, vReqDown, vReqCar], false)})`),

  mkEdge(stFloorDispatch, stSwitchDown, floorsSliceSwitch(false)),

  mkEdge(stFloorDispatch, stSwitchUp, floorsSliceSwitch(true)),

  mkEdge(stFloorDispatch, stSwitchIdle, `!(${isMode(mIdle)}) && ${setIsEmpty([vReqUp, vReqDown, vReqCar])}`),
]



for (let i of rangeN) {
  const up = floorIActive([vReqUp], i)
  const down = floorIActive([vReqDown], i)
  const xs = [
    floorIActive([vReqCar], i)
  ]
  if (up) {
    xs.push(`(${isMode(mUp)} && ${up})`)
  }
  if (down) {
    xs.push(`(${isMode(mDown)} && ${down})`)
  }
  edgeDecl.push(mkEdge(
    stFloorDispatch,
    `${stFloorHandle}${i}`,
    `${vFloor} == ${i} && !(${isMode(mIdle)}) && (${xs.join(" || ")})`
  ))
}



const floorHandleStateNames = floorHandleStates.map(([s]) => s)

edgeDecl.push(
  mkEdge(stSwitchUp, stFloorDispatch),
  mkEdge(stSwitchDown, stFloorDispatch),
  mkEdge(stSwitchIdle, stFloorDispatch),
  mkEdge(stFloorIncr, stFloorDispatch),
  mkEdge(stFloorDecr, stFloorDispatch),
  ...floorHandleStateNames.map(s => mkEdge(s, stFloorDispatch)),
  // this can be unconditional
  mkEdge(stFloorDispatch, stFloorDispatch, `${isMode(mIdle)} && ${setIsEmpty([vReqUp, vReqDown, vReqCar])}`)
)

if (optEffect) {
  stateDecl.push(mkState(
    stFloorDispatch,
    rangeN
      .map(i => setSelect([vReqUp, vReqDown, vReqCar], i).map(v => {
        const eff = pfReplace(v, pfEff)
        const xs = [
          `fresh(${eff})`,
          `${v} = ${v} || ${eff}`
        ]
        if (optPropCheck) {
          const acc = pfReplace(v, pfAcc)
          xs.push(`${acc} = ${acc} || ${eff}`)
        }
        if (isTestValidation) {
          // no repeat floor handling
          xs.push(`(${vFloor} == ${i}) => !${eff}`)
        }

        return xs
      }).flat())
      .flat(),
    ["start", "final"]
  ))

  const vg = [
    setBlast([vEffCar, vEffDown, vEffUp]).join(", "),
  ]

  if (optPropCheck) {
    vg.push(
      setBlast([vAccCar, vAccUp, vAccDown]).map(v => `${v} = ${pfReplace(v, pfReq)}`).join(", "),
      setBlast([vSwUp, vSwDown, vSwCar]).map(v => `${v} = ${pfReplace(v, pfReq)}`).join(", ")
    )
  }

  varDecl.push(
    `bool ${vg.join(", ")};`
  )
} else {
  stateDecl.push(mkState(stFloorDispatch, [], ["start", "final"]))
}

const goalStmt = []

if (!optDebug && !optPropCheck && !optEffect && !isTestValidation) {
  // expect the lift halts with idle
  goalStmt.push(`assert ${isMode(mIdle)};`)
}

if (initFloor != null && !optPropCheck) {
  goalStmt.push(`assert initial(${vFloor}) == ${initFloor};`)
  console.log("initial floor:", initFloor);
}

if (initMode && !optPropCheck) {
  goalStmt.push(`assert initial(${vMode}) == ${initMode};`)
  console.log("initial mode:", initMode);
}

const mkBlast = (xs, f, k) => {
  const ys = []
  for (let i = 0; i < k; i++) {
    if (xs.includes(i)) {
      ys.push(f(i))
    } else {
      ys.push(`!${f(i)}`)
    }
  }

  return ys
}

const mkExprInit = (xs, pf) => {
  const cut = pf === vReqUp ? [0, optN - 1] : pf === vReqDown ? [1, optN] : []
  return mkBlast(xs, i => `initial(${pf}_${i})`, optN).slice(...cut).join(" && ")
}

if (initReqCar && !optPropCheck) {
  goalStmt.push(`assert ${mkExprInit(initReqCar, vReqCar)};`)

  console.log("initial car:", initReqCar);
}

if (initReqUp && !optPropCheck) {
  goalStmt.push(`assert ${mkExprInit(initReqUp, vReqUp)};`)

  console.log("initial up:", initReqUp);
  if (initReqUp.includes(fMax)) {
    console.log(`invalid up-request to top-floor (${fMax})`);
    process.exit(0)
  }
}

if (initReqDown && !optPropCheck) {
  goalStmt.push(`assert ${mkExprInit(initReqDown, vReqDown)};`)
  console.log("initial down:", initReqDown);
  if (initReqDown.includes(0)) {
    console.log(`invalid down-request to ground-floor (0)`);
    process.exit(0)
  }
}

const reach = optDebug || optEffect
  ? `reach (${states.join(", ")})`
  : ``
const kFin = (optK || kMax)



let inv = 0
const mkInvariantProp = (expr, st) => {
  const id = inv ++
  return `invariant I${id} {${expr};}${st ? ` in (${st.join(", ")})` : ""}`
}

const exprPropLH1 = rangeN.map(i => [
  `(${setSelect([vReqUp, vReqDown, vReqCar], i).map(v => optEffect ? pfReplace(v, pfAcc) : `initial(${v})`).join(" || ")}) == ${vHandle}_${i}`,
  ...setSelect([vReqUp, vReqDown, vReqCar], i).map(v => `!${v}`)
].join(" && ")).join(" && ")

const propLH1 = mkInvariantProp(exprPropLH1, [stSwitchIdle])

const mkExprPropLH2 = i => {
  const up = setSelect([vReqUp], i)[0]
  const down = setSelect([vReqDown], i)[0]
  const car = `${vReqCar}_${i}`

  const initUp = optEffect ? `${vAccUp}_${i}` : `initial(${up})`
  const initDown = optEffect ? `${vAccDown}_${i}` : `initial(${down})`
  const initCar = optEffect ? `${vAccCar}_${i}` : `initial(${car})`

  const upExpr = up
    ? `!${up} && (${initUp} || ${initCar})`
    : initCar
  const downExpr = down
    ? `!${down} && (${initDown} || ${initCar})`
    : initCar


  return `!${car} && !(${isMode(mIdle)}) && ((${isMode(mUp)}) => (${upExpr})) && ((${isMode(mDown)}) => (${downExpr}))`
}

const propLH2 = rangeN.map(i => mkInvariantProp(mkExprPropLH2(i), [`${stFloorHandle}${i}`])).join("\n\n")


const expand2 = (f, v1 = vFloor, v2 = vFloorSD) => rangeN.map(i => rangeN.map(j => {
  const x = f(i, j)
  if (x) {
    return `((${v1} == ${i} && ${v2} == ${j}) => (${x}))`
  }
  return null
}).filter(it => it)).flat().join(" && ")

const expand1 = (f, v = vFloor) => rangeN.map(i => {
  const x = f(i)
  if (x) {
    return `((${v} == ${i}) => (${x}))`
  }
  return null
}).filter(it => it).join(" && ")

const exprPropMS1 = `${vFloorSU} <= ${vFloorSD}`
const propMS1 = mkInvariantProp(exprPropMS1)

const exprPropMS2 = `${vModePrev} != ${vMode}`

const propMS2 = mkInvariantProp(exprPropMS2, [stSwitchDown, stSwitchUp, stSwitchIdle])

const exprPropMS3D = `(${isMode(mDown)}) => (${vFloor} <= ${vFloorSD} && ${expand2((f, fsw) => {
  if (f < fsw) {
    const xs = []
    for (let i = f + 1; i <= fsw; i ++) {
      xs.push(...setSelect(optEffect ? [vSwCar, vSwDown] : [vReqCar, vReqDown], i).map(it => `!${it}`))
    }

    if (xs.length) {
      return xs.join(" && ")
    }
  }
}, vFloor, vFloorSD)})`

const propMS3D = mkInvariantProp(exprPropMS3D)

const exprPropMS3U = `(${isMode(mUp)}) => (${vFloorSU} <= ${vFloor} && ${expand2((f, fsw) => {
  if (fsw < f) {
    const xs = []
    for (let i = fsw; i < f; i ++) {
      xs.push(...setSelect(optEffect ? [vSwCar, vSwUp] : [vReqCar, vReqUp], i).map(it => `!${it}`))
    }

    if (xs.length) {
      return xs.join(" && ")
    }
  }
}, vFloor, vFloorSU)})`

const propMS3U = mkInvariantProp(exprPropMS3U)


const exprPropMS4D = `${isMode(mDown)} && ` + expand1(f => {
  const ys = []

  for (let i = 0; i <= f; i ++) {
    ys.push(setSelect([vReqDown, vReqUp, vReqCar], i).join(" || "))
  }

  if (ys.length) {
    return ys.join(" || ")
  }
}, vFloor)

const propMS4D = mkInvariantProp(exprPropMS4D, [stFloorDecr, stSwitchDown])

const exprPropMS4U = `${isMode(mUp)} && ` + expand1(f => {
  const ys = []

  for (let i = f; i < optN; i ++) {
    ys.push(setSelect([vReqDown, vReqUp, vReqCar], i).join(" || "))
  }

  if (ys.length) {
    return ys.join(" || ")
  }
}, vFloor)

const propMS4U = mkInvariantProp(exprPropMS4U, [stFloorIncr, stSwitchUp])

const invDecl = []

if (initPropLH == null || initPropLH.includes(0)) {
  invDecl.push(propLH1)
}

if (initPropLH == null || initPropLH.includes(1)) {
  invDecl.push(propLH2)
}

if (initPropMS == null || initPropMS.includes(0)) {
  invDecl.push(propMS1)
}


if (initPropMS == null || initPropMS.includes(1)) {
  invDecl.push(propMS2)
}


if (initPropMS == null || initPropMS.includes(2)) {
  invDecl.push(propMS3U, propMS3D)
}

if (initPropMS == null || initPropMS.includes(3)) {
  invDecl.push(propMS4U, propMS4D)
}


const v = x => x ? 1 : 0

const floorCount = rangeN.map(i => v(initReqDown.includes(i)) + v(initReqUp.includes(i)))

let condStmt = ""

switch (optTestValidation) {
  case tvPath: {
    const disj = floorCount.map((cnt, i) => {
      if (cnt !== 0) {
        return `!${stFloorHandle}${i}`
      }
      return null
    }).filter(it => it)
    if (disj.length) {
      condStmt = `condition (${disj.join(" || ")})`
    } else {
      console.log("invalid validation: empty conditions");
      process.exit()
    }
    break
  }
}

const checkStmt = `check for ${kFin} ${condStmt} ${reach}`

const spec = `option-trace = true;
graph Lift${optN} {
${varDecl.join("\n")}

${stateDecl.join("\n")}

${edgeDecl.join("\n")}

${optPropCheck ? invDecl.join("\n") : ""}
goal {
${goalStmt.join("\n")}
${checkStmt}
}
}`


fs.writeFileSync(optOut, spec, "utf-8")

console.log("generated:", optOut);