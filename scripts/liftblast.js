const fs = require("fs")

let optN = 3
let optK = 0
let optEffect = false
let optDebug = false
let optPropCheck = true
let optPropAgg = true
let optOut = null

const mUp = "U"
const mDown = "D"
const mIdle = "I"

let initFloor = 1
let initMode = mIdle
let initReqCar = [0, 1, 2]
let initReqUp = [0, 1]
let initReqDown = [1, 2]

let initPropHalt = null // [0]
let initPropIdle = null // [0, 1, 2]
let initPropLH = null // [1, 2]
let initPropMS = null // [0, 1, 2, 3] // 0, 1, 2 (U, D), 3 (U, D)

const input = process.argv[2].trim()
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
      if (conf.optPropAgg != null) optPropAgg = conf.optPropAgg
      if (conf.optEffect != null) optEffect = conf.optEffect
      if (conf.optOut != null) optOut = conf.optOut
      if (conf.initPropHalt != null) initPropHalt = conf.initPropHalt
      if (conf.initPropIdle != null) initPropIdle = conf.initPropIdle
      if (conf.initPropLH != null) initPropLH = conf.initPropLH
      if (conf.initPropMS != null) initPropMS = conf.initPropMS

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

if (!optDebug && !optEffect && (optK % 2 !== 0)) {
  console.log("invalid k: expected (k mod 2 == 0) for non-effect");
  process.exit(0)
}

console.log("floors:", optN);
console.log("steps:", optK);
console.log("debug:", optDebug);
console.log("effect:", optEffect);
console.log("property check:", optPropCheck);
console.log("property aggregation:", optPropAgg);

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

    // if (consRest && vc.length) {
    //   xs.push(`${isEmpty ? "" : "!"}(${vc.join(" || ")})`)
    // } else if (consRest) {
    //   return null
    // }

    // if (xs.length === 1) {
    //   return null
    // }

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
  if (optPropCheck) {
    stmt.push(`sc += 1`)
    stmt.push(`sc_${id} += 1`)
  }
  return `${stmt.length ? "normal " : ""}${mods.length ? mods.join(" ") + " " : ""}state ${id} {${stmt.map(s => s.endsWith(";") ? s : s + ";").join(" ")}}`
}

const mkEdge = (s, t, c) => `edge {${s} -> ${t}${c ? ` where ${c};` : ""}}`

// const switchStmt = optPropCheck 
//   ? [`${vFloorPrev} = ${vFloor}`] 
//   : []

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
    if (optEffect) {
      xs.push(`${vSwCar}_${i} = false`)
    }
    if (i !== fMax) {
      xs.push(`${vReqUp}_${i} = ${vReqUp}_${i} && !(${isMode(mUp)})`)
      if (optEffect) {
        xs.push(`${vSwUp}_${i} = ${vSwUp}_${i} && !(${isMode(mUp)})`)
      }
    }
    if (i !== 0) {
      xs.push(`${vReqDown}_${i} = ${vReqDown}_${i} && !(${isMode(mDown)})`)
      if (optEffect) {
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
  varDecl.push(`int sc = 0, ${states.map(s => `sc_${s} = 0`).join(", ")};`)
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
    // edgeDecl.push(stFloorDispatch, `${stFloorHandle}${i}`, `(${isMode(mIdle)} && ${floorOnlyI(i)}) || (!(${isMode(mIdle)}) && (${floorIActive([vReqUp, vReqDown, vReqCar], i)}))`)
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

// const effToReq = v => v.startsWith(vEffCar) ? vReqCar : v.startsWith(vEffUp) ? vReqUp : vReqDown


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
  // edgeDecl.push(
  //   mkEdge(stSwitchUp, stEffect),
  //   mkEdge(stSwitchDown, stEffect),
  //   mkEdge(stSwitchIdle, stEffect),
  //   mkEdge(stFloorIncr, stEffect),
  //   mkEdge(stFloorDecr, stEffect),
  //   ...floorHandleStateNames.map(s => mkEdge(s, stEffect)),

  //   mkEdge(stFloorDispatch, stEffect, `${isMode(mIdle)} && ${setIsEmpty([vReqUp, vReqDown, vReqCar])}`),
  //   mkEdge(stEffect, stFloorDispatch),
  // )
  stateDecl.push(mkState(
    stFloorDispatch, 
    rangeN
      .map(i => setSelect([vReqUp, vReqDown, vReqCar], i).map(v => {
        const eff = pfReplace(v, pfEff)
        const acc = pfReplace(v, pfAcc)
        return [
          `fresh(${eff})`, 
          `${v} = ${v} || ${eff}`,
          `${acc} = ${acc} || ${eff}`
        ]
      }).flat())
      .flat(),
      ["start", "final"]
  ))

  varDecl.push(
    `bool ${setBlast([vEffCar, vEffDown, vEffUp]).join(", ")}, ${setBlast([vAccCar, vAccUp, vAccDown]).map(v => `${v} = ${pfReplace(v, pfReq)}`).join(", ")}, ${setBlast([vSwUp, vSwDown, vSwCar]).map(v => `${v} = ${pfReplace(v, pfReq)}`).join(", ")};`
  )
} else {
  // edgeDecl.push(
  //   mkEdge(stSwitchUp, stFloorDispatch),
  //   mkEdge(stSwitchDown, stFloorDispatch),
  //   mkEdge(stSwitchIdle, stFloorDispatch),
  //   mkEdge(stFloorIncr, stFloorDispatch),
  //   mkEdge(stFloorDecr, stFloorDispatch),
  //   ...floorHandleStateNames.map(s => mkEdge(s, stFloorDispatch)),
  //   // this can be unconditional
  //   mkEdge(stFloorDispatch, stFloorDispatch, `${isMode(mIdle)} && ${setIsEmpty([vReqUp, vReqDown, vReqCar])}`)
  // )
  stateDecl.push(mkState(stFloorDispatch, [], ["start", "final"]))
}

const goalStmt = []

if (!optDebug && !optPropCheck && !optEffect) {
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
  // goalStmt.push(`assert ${bitsetEq(i => i == null ? `initial(${vReqCar})` : `initial(${vReqCar}_${i})`, mkBitset(initReqCar, optN))};`)
  goalStmt.push(`assert ${mkExprInit(initReqCar, vReqCar)};`)

  console.log("initial car:", initReqCar);
}

if (initReqUp && !optPropCheck) {
  // goalStmt.push(`assert ${bitsetEq(i => i == null ? `initial(${vReqUp})` : i !== fMax ? `initial(${vReqUp}_${i})` : undefined, mkBitset(initReqUp, optN))};`)
  goalStmt.push(`assert ${mkExprInit(initReqUp, vReqUp)};`)

  console.log("initial up:", initReqUp);
  if (initReqUp.includes(fMax)) {
    console.log(`invalid up-request to top-floor (${fMax})`);
    process.exit(0)
  }
}

if (initReqDown && !optPropCheck) {
  // goalStmt.push(`assert ${bitsetEq(i => i == null ? `initial(${vReqDown})` : i !== 0 ? `initial(${vReqDown}_${i})` : undefined, mkBitset(initReqDown, optN))};`)
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

goalStmt.push(`check for ${kFin} ${reach}`)



let inv = 0
const mkInvariantProp = (expr, st) => {
  const id = inv ++
  return `invariant I${id} {${expr};}${st ? ` in (${st.join(", ")})` : ""}`
}

const mkAssertProp = expr => optPropAgg 
  ? `invariant I${inv ++} {(sc == ${kFin + 1}) => (${expr});} // agg`
  : `assert !(${expr});`

const exprPropHalt = `${isMode(mIdle)} 
  && sc_${stSwitchIdle} + sc_${stSwitchUp} + sc_${stSwitchDown} <= 4
  && ${rangeN.map(i => `sc_${stFloorHandle}${i}`).join(" + ")} <= ${2 * optN}
  && sc_${stFloorIncr} + sc_${stFloorDecr} <= ${2 * optN - 3}`

const propHalt = mkAssertProp(exprPropHalt)

const exprPropHaltSimple = `${isMode(mIdle)}`
const propHaltSimple = `assert !(${exprPropHaltSimple});`

const exprPropIdle1 = `sc_${stSwitchIdle} <= 1 && (sc_${stSwitchIdle} == 1) => (${isMode(mIdle)} && ${setBlast([vReqCar, vReqUp, vReqDown]).map(it => `!${it}`).join(" && ")})`
const propIdle1 = mkInvariantProp(exprPropIdle1)

const exprExistsInitReq = setBlast([vReqCar, vReqUp, vReqDown]).map(it => `initial(${it})`).join(" || ")

const exprPropIdle2 = `(sc_${stSwitchUp} + sc_${stSwitchDown} != 0) => (sc_${stSwitchIdle} == 1)`

const propIdle2 = mkAssertProp(exprPropIdle2)

const exprPropIdle3 = `(initial(${vMode}) == ${mIdle} && sc == 2 && (${exprExistsInitReq})) => (${isMode(mUp)} && sc_${stSwitchUp} == 1 || ${isMode(mDown)} && sc_${stSwitchDown} == 1)`

const propIdle3 = mkInvariantProp(exprPropIdle3)

// `initial(${it}) == (sc_${stFloorHandle}${xs[xs.length - 1]} != 0)`
const exprPropLH1 = rangeN.map(i => [
  `(${setSelect([vReqUp, vReqDown, vReqCar], i).map(v => optEffect ? pfReplace(v, pfAcc) : `initial(${v})`).join(" || ")}) == (sc_${stFloorHandle}${i} != 0)`,
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
    // const c1 = `((${i} < ${vFloor}) => (${setSelect([vReqDown, vReqUp, vReqCar], i).join(" || ")}))`
    // const c2a = setSelect([vReqUp], i)[0]
    // const c2b = setSelect([vReqDown, vReqCar], i).map(it => `!${it}`).join(" && ")
    // const c2 = `((${i} == ${vFloor}) => (${[c2a, c2b].filter(it => it).join(" && ")}))`
    // ys.push(`(${[c1, c2].join(" && ")})`)
    // ys.push(c1)
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


// const negCurrentInitial = expandCurrentInitial((f, initF) => {
//   if (initF - f > 0) {
//     const xs = []
//     for (let i = f+1; i <= initF; i++) {
//       xs.push(`!${vReqCar}_${i}`)
//       xs.push(...setSelect([vReqDown], i).map(it => `!${it}`))
//     }
//     if (xs.length) {
//       return xs.join(" && ")
//     }
//   }

//   return null
// }).join(" && ")

// const negCurrentAbove = expandCurrent(f => {
//   const xs = []
//   for (let i = f + 1; i < optN; i++) {
//     xs.push(`!${vReqCar}_${i}`)
//     xs.push(...setSelect([vReqDown, vReqUp], i).map(it => `!${it}`))
//   }

//   if (xs.length) {
//     return xs.join(" && ")
//   }
// }).join(" && ")

// const exprPropMS2D = `(${isMode(mDown)}) => ((sc_${stSwitchUp} == 0 && ${negCurrentInitial}) || (sc_${stSwitchUp} != 0 && ${negCurrentAbove}))`

// const propMS2D = mkInvariantProp(exprPropMS2D)

// const exprPropMS3D = `(sc_${stSwitchDown} == 1 && sc_${stSwitchUp} == 1) => (${expandCurrent(i => setSelect([vReqCar, vReqUp], i).map(it => `!${it}`).join(" && "), true).join(" && ")})`

// const propMS3D = mkInvariantProp(exprPropMS3D, [stSwitchDown])

// const exprPropMS4D = `(sc_${stSwitchDown} == 2) => (sc_${stSwitchUp} == 1 && ${rangeN.map(i => {
//   const xs = setSelect([vReqUp, vReqCar], i).map(it => `!${it}`)
//   const d = setSelect([vReqDown], i)[0]
//   if (d) {
//     xs.push(`!(${i} <= initial(${vFloor}) && ${d})`)
//   }

//   return xs.join(" && ")
// }).join(" && ")})`

// const propMS4D = mkInvariantProp(exprPropMS4D, [stSwitchDown])

// const invDecl = [
//   "// halt",
//   propHalt,
//   "\n",
//   "// idling",
//   propIdle1,
//   propIdle2,
//   propIdle3,
//   "\n",
//   "// level-handling",
//   propLH1,
//   propLH2,
//   "\n",
//   "// mode-switching",
//   propMS1D,
//   propMS2,
//   propMS3,
//   propMS4,
//   "\n"
// ]

const invDecl = []

if (!optEffect) {
  if (initPropHalt == null || initPropHalt.includes(0)) {
    invDecl.push(propHalt)
  }

  if (initPropHalt == null || initPropHalt.includes(1)) {
    goalStmt.push(propHaltSimple)
  }

  if (initPropIdle == null || initPropIdle.includes(0)) {
    invDecl.push(propIdle1)
  }

  if (initPropIdle == null || initPropIdle.includes(1)) {
    invDecl.push(propIdle2)
  }


  // invDecl.push(
  //   "// halt",
  //   propHalt,
  //   "\n",
  //   "// idling",
  //   propIdle1,
  //   propIdle2,
  // )
}

if (initPropIdle == null || initPropIdle.includes(2)) {
  invDecl.push(propIdle3)
}

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

// invDecl.push(
//   propIdle3,
//   "\n",
//   "// level-handling",
//   propLH1,
//   propLH2,
//   "\n",
//   "// mode-switching",
//   propMS1U,
//   propMS1D,
//   propMS2,
//   propMS3,
//   propMS4U,
//   propMS4D,
//   "\n"
// )

if (optPropCheck && !optPropAgg) {
  console.log(invDecl.join("\n"));
}

const spec = `option-trace = true;
graph Lift${optN} {
${varDecl.join("\n")}

${stateDecl.join("\n")}

${edgeDecl.join("\n")}

${optPropCheck && optPropAgg ? invDecl.join("\n") : ""}
goal {
${goalStmt.join("\n")}
}
}`


fs.writeFileSync(optOut, spec, "utf-8")

console.log("generated:", optOut);