# Verifying an Elevator Scheduling Control System

Materials of *Verifying an Elevator Scheduling Control System* by Huan Zhang, Haoyang Lu, Long Cheng and Hao Wu. 

This work has been accepted by The 10th International Workshop on Testing Extra-Functional Properties and Quality Characteristics of Software Systems (ITEQS@ICST 2026).

**Abstract:** Elevators are crucial for modern buildings, transporting large volumes of passengers across multiple floors every day. Among their components, the scheduling control system plays a central role in determining passenger waiting times and overall efficiency. However, traditional simulation-based testing is time-consuming and costly, which limits its scalability.

We present an approach that combines both verification and testing for elevator scheduling systems. Our technique models the scheduling logic as a state machine and translates it into Satisfiability Modulo Theories (SMT) formulas that can be efficiently solved and tested by SMT solvers. Preliminary evaluation shows that our technique can verify key properties of scheduling control logic. Our experimental results demonstrate that the approach scales reasonably well with increasing numbers of floors and requests. This can provide a potential practical and automated verification solution for industrial elevator controllers.

## Contents
This repository contains the following directories:

- `example`: [Cyclone specifications of a 3-floor example elevator model](https://github.com/lucid-brndmg/elevator-cyclone-smt/tree/master/example)
- `elevator_gen`: Program for generating N-floor elevator Cyclone specifications
- `prop`: Pre-generated SMT2 formulas, specifications and scripts for property verification (Table 3, 4)
- `scene`: Pre-generated SMT2 formulas, specifications and scripts for scenario testing (Table 5, 6)
- `tools`: Cyclone release, SMT solvers and utility scripts of our experiments for X86-64 Linux

This document contains the following instructions:
- [Reproducing table 3-6 in paper using provided SMT2 formulas](#reproducibility-instructions)
- [How to check Cyclone specifications directly](#running-cyclone-specification)
- [How to generate SMT2 formula from Cyclone Specification](#generating-smt2-from-cyclone-specifications)

Useful Links:
- [Cyclone Online Editor](https://cyclone.cs.nuim.ie)
- [Download Cyclone](https://classicwuhao.github.io/cyclone_tutorial/installation.html)

## REPRODUCIBILITY INSTRUCTIONS

The following instructions are for reproducing the results from Table 3-6 in the paper on a **x86-64 Linux operating system** using provided SMT2 formulas. At least 16GB of memory, 16GB of disk space is required. 

### Step 1: Preparation

Clone this repository and enters the project root folder:
```shell
git clone https://github.com/lucid-brndmg/elevator-cyclone-smt.git
cd elevator-cyclone-smt
```

Enter `tools` and initialize required tools. This should be run only once after cloning. This automatically downloads Java and unzips nodejs for further steps. 

```shell
cd tools

# download openjdk
wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
tar xf openjdk-11.0.2_linux-x64_bin.tar.gz

# extract nodejs
tar xf node-v20.19.6-linux-x64.tar.xz

# setup privilege
chmod +x bitwuzla cvc5 cyclone-java cyclone-java-gen cyclone-rs mathsat opensmt stp yices-smt2 z3

cd ..
chmod +x env.sh
```

Setup environment variables for tools temporarily. Note that **this step is always required when opening a new shell**. 

```shell
# at project root
# Execute this before any further steps, and for each new shell
source ./env.sh
```

In further steps, some scripts takes hours to run, and one can open new shells to run scripts in parallel. Each time a new shell is opened, **please rerun `source env.sh` at project root** for environment setup. Optionally, one can adding this script to `~/.profile` to automate this step.

The remaining steps begins at the project root folder `elevator-cyclone-smt`. Please make sure to switch there first. 

### Step 2: Property Verification (Table 3, 4)

This step shows how to reproduce data of Table 3, 4 of the paper. The required formulas and scripts are at `prop` folder. The first step is to switch to there and extract formulas (requires approx. **4GB of disk space**). 

```shell
cd prop
unzip formulas.zip
chmod +x *.sh
```

Now the `prop` folder contains 3 kinds of files:
- Cyclone specifications: Files with `.cyclone` extensions. [How to directly running a `.cyclone` file?](#running-cyclone-specification) 
- Pre-generated SMT2 formulas: Files with `.smt2` extensions. These files are generated from `.cyclone` specifications. [How to generate these formulas?](#generating-smt2-from-cyclone-specifications)
- Set of `.sh` scripts. Each script calls an SMT solver to solve a set of `.smt2` formulae and generates outputs. 

We focus on the scripts. The naming of each script follows `{solver}-{encoding}.sh` where `solver` corresponds to an SMT solver and `encoding` is either `int` (integer encoding) or `bv` (bit-vector encoding). [See here for solver correspondence.](#smt-lib-solver-reference) 

By executing a particular script, a set of SMT formulae is solved, and outputted to a log file. Time consumption is recorded in the log file, which is the data of table 3, 4. **Each script takes more than 4 hours, and some scripts take more than 10 hours to be fully executed.**

#### Sequential Execution (Not Recommended)
To sequentially execute each:

```shell
./bitwuzla-bv.sh
./cvc5-int.sh
./mathsat-int.sh
./opensmt-int.sh
./stp-bv.sh
./yices2-bv.sh
./yices2-int.sh
./z3-bv.sh
./z3-int.sh
```

Every SMT2 formula has a 2-hour timeout. It might take days to fully execute every shell file. 

#### Parallelized Execution (Recommended, Require Multiple CPU Cores)

Since each SMT solver uses only 1 CPU core, it is recommended to parallelize the solving process by opening new shells. For instance, in shell A using MathSAT, in shell B using Z3 (integer encoding), and in shell C using Z3 (bit-vector encoding):

```shell
# shell A, B, C requires env.sh of previous step to be executed beforehand. 
# at Shell A
bash mathsat-int.sh
# at Shell B
bash z3-int.sh
# at Shell C
bash z3-bv.sh
# ...
```

Here the 3 shells in total takes approximately 12 hours to be fully executed (instead of 36 hours, when running sequentially). One can open as many shells as the number of CPU cores. 

#### Single-Solver Example (MathSAT Solver)
For example, to solve integer-encoding formulas using [MathSAT](https://mathsat.fbk.eu/downloadall.html) solver:

```shell
# make sure env.sh of previous step is executed
# current dir: prop
bash mathsat-int.sh
```

By doing this totally 56 SMT2 formulas are solved. A list of output files staring with `out_ms` is produced, containing satisfiable results and time consumption of particular floor elevator. One can find time consumption information by opening, for instance, `out_ms3.txt` (solving logs of 3-floor elevator formulas) and look for the `:time-seconds` keyword. [More info on output](#manual-output-interpretation)

#### Output Interpretation

After all of `.sh` scripts being executed, we can recover the data of table 3 and table 4 automatically:

```shell
# at prop directory
node output.js
```

This generates a `time.csv` file, containing time consumptions for each solver and each formula. In this CSV there are 8 columns for each row:
1. `solver`: The SMT solver of the row
2. `encoding`: Either `int` (integer) or `bv` (bit-vector)
3. `cyclone-version`: Either `cyclone-java` (Java version) or `cyclone-rust` (Rust version)
4. `config-type`: Either `fixed` or `dynamic`
5. `floors`: Number of floors, one of `3, 5, 10, 15`
6. `steps`: Number of verification steps, only meaningful for dynamic-config (See table 4)
7. `property`: Which set of property being verified, one of FR, DS, ALL
8. `time`: Time in seconds, or `TO` if time out after 2 hours

### Step 3: Scenario Testing (Table 5, 6)

This step shows how to reproduce data of Table 5, 6 of the paper. The required formulas and scripts are at `scene` folder. The first step is to switch to there and extract formulas (requires approx. **15GB of disk space**).

```shell
cd scene
# there are multiple zip files
# the 'quotes' are mandatory
unzip 'form*.zip' 
chmod +x *.sh
```

Now `scene` directory also contains 3 kinds of files similar to step 2. The remaining steps are the same as step 2: 
1. Execute all `.sh` scripts sequentially or in parallel. Each script takes about 30 minutes to 1 hour to be executed. At least 24GB of memory is required, otherwise some test cases might ran out of memory, causing a script to exit unexpectedly. 
2. Execute `node output.js` to get `time.csv` as result. The result corresponds to Table 6 in the paper. 

The `time.csv` output consists of 5 columns:
1. `solver`: The SMT solver used.
2. `encoding`: Either `int` or `bv`.
3. `cyclone-version`: Either `cyclone-rust` or `cyclone-java`.
4. `scenario`: Scenario ID from 1 to 10 (See Table 5 in paper)
5. `time`: Solving time in seconds, or `TO` if time out. 

Now both tables should be reproduced. The following sections are further readings only for reference. 

### SMT-LIB Solver Reference

SMT-LIB solvers (version corresponds to paper) and corresponding script of step 2, 3, and output prefix are listed at following table. Column 'Output Time-keyword' is the keyword to locate line of time consumption in raw output files (staring with `out_`). 

|Solver|Script|Encoding|Raw Output Prefix|Output Time-Keyword|
|---|---|---|---|---|
|[Z3 (4.15.2)](https://github.com/Z3Prover/z3/releases/tag/z3-4.15.2)|`z3-int.sh`|Integer|`out_z3`|`:time`|
|[CVC5 (1.3.1)](https://github.com/cvc5/cvc5/releases/tag/cvc5-1.3.1)|`cvc5-int.sh`|Integer|`out_c5`|`global::totalTime`|
|[Yices2 (2.7)](https://github.com/SRI-CSL/yices2/releases/tag/yices-2.7.0)|`yices2-int.sh`|Integer|`out_y2`|`:total-run-time` (in ms)|
|[OpenSMT (2.9.2)](https://github.com/usi-verification-and-security/opensmt/releases/tag/v2.9.2)|`opensmt-int.sh`|Integer|`out_osmt` and `out_osmt_time`|`user` (in `out_osmt_time`)|
|[MathSAT5 (5.6.14)](https://mathsat.fbk.eu/downloadall.html)|`mathsat-int.sh`|Integer|`out_ms`|`:time-seconds`|
|Z3 (4.15.2)|`z3-bv.sh`|Bit-Vector|`out_z3bv`|See above|
|Yices2 (2.7)|`yices2-bv.sh`|Bit-Vector|`out_y2bv`|See above|
|[STP (2.3.4)](https://github.com/stp/stp/releases/tag/2.3.4_cadical)|`stp-bv.sh`|Bit-Vector|`out_stp`|`CPU Time`|
|[Bitwuzla (0.8.2)](https://github.com/bitwuzla/bitwuzla/releases/tag/0.8.2)|`bitwuzla-bv.sh`|Bit-Vector|`out_bitwuzla`|`solving_context::time_solve` (in ms)|

#### Manual Output Interpretation

Optionally one may open raw output file (starting by `out_`, from step 2 or 3) to interpret results. Contents of each output file are ordered by files of each script, separated in the following segments:
- Is the input formulas satisfiable? (`sat, unsat` or timeout messages)
- Before the end of segment: Solver statistics, including **time consumption of solving** (Specially, time is written to a separated file `out_osmt_time` of OpenSMT)
- A line denotes the end of segment: `fin {file}.smt2`

Here is an example segment from an output file produced at `prop/out_y25.txt`:
```
unsat
(
 ...
 :total-run-time 0.060
 ...
)
fin l5_dyn_l01m0123_4.cyclone_gen.smt2
```

The above output consists the following information:
- Filename `out_y25`: This output is generated by yices2 solver, consists solving outputs of 5-floor elevators.
- The solving result is unsatisfiable (`unsat`)
- The total solving time is `0.060` seconds.  
- From `fin {filename}.smt2`: This is the verification result of an 5-floor elevator, under dynamic configuration and bounded for 4 steps. This formula is generated by Cyclone (java version). [How are SMT2 files being named?](#filenames-explained)

### Filenames Explained

#### Property Filenames

From step 2 at `prop` directory, the naming of Cyclone specifications and SMT2 formulas consists 4 segments `l{floors}_{config}_{properties}_{steps}` where:
- `floors` is the total number of floors
- `config` is either `stc` (for fixed configuration) or `dyn` (for dynamic configuration)
- `properties` consists of verified properties, where `l01` denotes Floor Reachability (FR) properties, and `m0123` denotes Direction Switching (DS) properties. 
- `steps` only exists for dynamic configuration files, which marks the number of steps (4, 8, 16, 32).

For instance, a 10-floor elevator under fixed configuration having FR and DS properties is named `l10_stc_l01m0123`. The corresponding Cyclone specification is then `l10_stc_l01m0123.cyclone`. 

#### SMT2 Suffix
The `smt2` files have different file suffix from different [formula-generation approaches](#generating-smt2-from-cyclone-specifications). The following table explains the source. Each `.cyclone` specification generates the following 3 variations of SMT2 formulas:

|SMT2 Suffix|Compiler|Description|
|---|---|---|
|`.cyclone_gen.smt2`|Cyclone (Java)|Integer encoding (`QF_LIA` logic of SMT-LIB)|
|`.lia.smt2`|Cyclone (Rust)|Integer encoding (`QF_LIA` logic of SMT-LIB)|
|`.bv.smt2`|Cyclone (Rust)|Bit-Vector encoding (`QF_BV` logic of SMT-LIB)|


## Additional Instructions

The above instruction explains how to solve each pre-generated SMT2 file. The following section explains how to generate SMT2 formulas from cyclone specifications, and how to generate cyclone specifications from scripts. 

Here we assume [step 1 of above instruction](#step-1-preparation) is prepared and `source env.sh` is executed beforehand.

### Running Cyclone Specification

There are 3 ways to run a Cyclone specification. 

#### Online Editor
Copy & paste the content of a particular `.cyclone` file to [Cyclone online editor](https://cyclone.cs.nuim.ie/editor). Click "Run" button to see effect. 

**NOTE:** Online editor has a 10-second hard timeout. For property verification it would be better to run locally. 

#### Cyclone (Java)
We provide a script `cyclone-java` for running Cyclone (Java) locally (version 1.10.1359). Alternatively please refer to [Cyclone installation](https://classicwuhao.github.io/cyclone_tutorial/installation.html) for using a different version. Here we take [the instance of `l3_stc.cyclone`](https://github.com/lucid-brndmg/elevator-cyclone-smt/blob/master/example/l3_stc.cyclone):

```shell
cyclone-java l3_stc.cyclone
```

Cyclone then outputs:
```
./l3_stc.cyclone
Generating graph conditions...
Generation is successful.
Mode: Enumeration
Options: [trace:true]
Generated Conditions:  120584
Launching solver...
Solver:  Z3-4.13.0.0 (amd64)
Path 0: D->SetMotionDown->D->MoveDown->D->SetMotionUp->D->L0->D->SetIdle->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D
Solving completed:335 msc
Total Path(s): 1
Trace Generated:/path/to/trace/l3_stc.trace
Time Spent:442 msc
```

Notice that time here also includes compilation time. One can investigate the trace in corresponding location. 

#### Cyclone (Rust)
Optionally, one can try out Cyclone (Rust version) as an alternative. It uses different encoding than Java version:
```shell
cyclone-rs l3_stc.cyclone
```

Which outputs:
```
Cyclone (Rust) : Alternative Unofficial Cyclone Implementation
Repository: https://github.com/lucid-brndmg/cyclone-rs
Use -h to see options

Input: l3_stc.cyclone
Solver: Z3 4.15.1.0 b665c99d0608fd392b951a04559191f97a51eb38 NOTFOUND

Estimated maximum graph analysis complexity: 2106 edges
Enumerating for length 26, possible paths: 717897987691852588770249

Checking length: 26, reachable nodes: 227, choice points: 225, optimized checks: 0
Path 0 (length 26): D->SetMotionDown->D->MoveDown->D->SetMotionUp->D->L0->D->SetIdle->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D->D
=== TRACE ===

... TOML format trace output ...
```

### Generating SMT2 From Cyclone Specifications

There are 3 ways to generate SMT2 files from Cyclone specification, corresponds to [3 entries of this table](#smt2-suffix). Here we assume input file is `l3_dyn.cyclone` (a 3-floor elevator in fixed configuration). 

#### Using Cyclone (Java)

Use the provided `cyclone-java-gen` script (requires first `source env.sh`) to automatically generate SMT2:

```shell
cyclone-java-gen l3_dyn.cyclone
```

Generates a `l3_dyn.cyclone_gen.smt2` in integer encoding. To modify Java memory allocation settings (JVM's `-Xss` and `-Xmx`), one may manually change `tools/cyclone-java-gen` script. 

Note that it is very time-consuming for generating large amount of (typically above 45) floors.

#### Using Cyclone (Rust) with Integer Encoding

Option `option-generation` is NOT supported in the Rust version. Instead, it uses a command-line argument `--codegen out.smt2`. For instance:

```shell
# optionally use --stack-size <bits> to adjust stack size for large input
cyclone-rs l3_dyn.cyclone --codegen l3_dyn.smt2
```

Then `l3_dyn.smt2` can be checked by Z3 or other solvers. The output SMT2 file is in integer encoding. Notice it is memory-consuming for generating 50-floors. If `cyclone-rs` exit unexpectedly, set `--stack-size 536870912` to increase stack size. 

#### Using Cyclone (Rust) with Bit-Vector Encoding

Additionally, the Rust version supports automatic conversion for `int` to signed `bv`. For a 3-floor elevator, it takes `ceil(log2(3)) + 1 = 3` bits to correctly represent maximum possible integer (i.e, the floor) in specification. Hence, one can generate BV formulas by:

```shell
# optionally use --stack-size <bits> to adjust stack size for large input
cyclone-rs l3_dyn.cyclone --codegen l3_dyn.bv.smt2 --option-bv-int --option-bv-int-size 3
```

The resultant `l3_dyn.bv.smt2` file then can be solved by BV solvers, such as STP and Bitwuzla. 

### Generating Cyclone Specifications

Specification generation script is placed at `elevator_gen/gen.js`. To generate a Cyclone specification for any number of floor, one may pass configuration as argument.

For example, to generate a 3-floor fixed-configuration elevator model that initially idled at L1 with initial up and down request at L1, car request at L0 and path length of 26:
```shell
node elevator_gen/gen.js '{"optN":3,"optK":26,"optPropCheck":false,"optDebug":false,"optEffect":false,"optOut":"example.cyclone","initFloor":1,"initReqUp":[1],"initReqDown":[1],"initReqCar":[0],"initMode":"I"}'
```

Further explanation of the above configuration argument:

```json5
{
    // total number of floors
    "optN": 3,
    // total number of checking steps
    "optK": 26,
    // is a property-verification file? 
    "optPropCheck": false,
    "optDebug": false,
    // is a dynamic configuration?
    "optEffect": false,
    // output specification filename
    "optOut": "example.cyclone",
    // the elevator is initially at (0-based)
    "initFloor": 1,
    // the set of initial up-calls (0-based)
    "initReqUp": [
        1
    ],
    // the set of initial down-calls (begins at L1)
    "initReqDown": [
        1
    ],
    // the set of initial car-calls (0-based)
    "initReqCar": [
        0
    ],
    // initial direction: I (idle), D (down) or U (up)
    "initMode": "I",

    // --- (optional) properties to be proven ---
    // only takes effect if "optPropCheck": true
    "initPropFR": [0, 1], // FR property, ranges 0 to 1
    "initPropDS": [0, 1, 2, 3] // DS property, ranges 0 to 3
}
```

Notice if `optPropCheck = true`, then `initFloor, initMode, initReq*` are ignored, because in property checking mode. 