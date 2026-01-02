# Verifying an Elevator Scheduling Control System

Materials of *Verifying an Elevator Scheduling Control System* by Huan Zhang, Haoyang Lu, Long Cheng and Hao Wu. 

[This set of example specifications](https://github.com/lucid-brndmg/elevator-cyclone-smt/tree/master/example) consists details and explanations of modeling and instruction of running each specification locally or online. Remaining document focus on reproducibility. 

## REPRODUCIBILITY INSTRUCTIONS

The following instructions are for reproducing the results from Table 3-6 in the paper. 

### Pre-requirement
- A POSIX-based operating system (Linux, MacOS or [Windows-WSL](https://learn.microsoft.com/en-us/windows/wsl/install)). 
- Series of SMT-LIB solver installed and configured in `PATH`, including: [Z3](https://github.com/Z3Prover/z3), [CVC5](https://cvc5.github.io/), [Yices2](https://yices.csl.sri.com/), [OpenSMT](https://github.com/usi-verification-and-security/opensmt), [MathSAT5](https://mathsat.fbk.eu/), [STP](https://stp.github.io/) and [Bitwuzla](https://bitwuzla.github.io/). Full list of solver identifier and corresponding output please see table below. 
- At least **16GB of memory** is required for solving large formulae, and 24GB is required for generating `.smt2` from `.cyclone` specifications. 
- At least **16GB of disk space** is required for uncompressing the SMT2 formulae. 
- (Optional) Installation of [Cyclone (Java)](https://classicwuhao.github.io/cyclone_tutorial/installation.html) for running specific `.cyclone` files.
- (Optional) Installation of Cyclone (Rust): A Linux binary can be found at `/cyclone-versions/cyclone-rs.zip`. Unzip the file to get an executable. 
- (Optional) Installation of [Node.js](https://nodejs.org/en) for generating Cyclone specifications. 

### SMT-LIB Solver Configurations

Both `/prop` and `/scene` directories contains a `formulae.zip` file containing SMT2 formulae and Cyclone specifications, and series of Bash scripts starting with `exec_[solver]` for reproducing solving process. When executing each script, there will be output file starting with `out_[solver]` suffix. 

The list of SMT-LIB solvers (version corresponds to paper), corresponding script identifier and output are recorded at following table. **File of 'Executable' should be inside `PATH` before execution of `.sh` script.** Column 'Time keyword' is the keyword to locate line of time consumption in output file. 

|Solver|Executable|Encoding|Script Prefix|Output Prefix|Time Keyword|
|---|---|---|---|---|---|
|[Z3 (4.15.2)](https://github.com/Z3Prover/z3/releases/tag/z3-4.15.2)|`z3`|Integer|`exec_z3`|`out_z3`|`:time`|
|[CVC5 (1.3.1)](https://github.com/cvc5/cvc5/releases/tag/cvc5-1.3.1)|`cvc5`|Integer|`exec_cvc5`|`out_c5`|`global::totalTime`|
|[Yices2 (2.7)](https://github.com/SRI-CSL/yices2/releases/tag/yices-2.7.0)|`yices-smt2`|Integer|`exec_y2`|`out_y2`|`:total-run-time` (in ms)|
|[OpenSMT (2.9.2)](https://github.com/usi-verification-and-security/opensmt/releases/tag/v2.9.2)|`opensmt2`|Integer|`exec_osmt`|`out_osmt` and `out_osmt_time`|`user` (in `out_osmt_time`)|
|[MathSAT5 (5.6.14)](https://mathsat.fbk.eu/downloadall.html)|`mathsat`|Integer|`exec_ms`|`out_ms`|`:time-seconds`|
|Z3 (4.15.2)|`z3`|Bit-Vector|`exec_z3bv`|`out_z3bv`|See above|
|Yices2 (2.7)|`yices-smt2`|Bit-Vector|`exec_y2bv`|`out_y2bv`|See above|
|[STP (2.3.4)](https://github.com/stp/stp/releases/tag/2.3.4_cadical)|`stp`|Bit-Vector|`exec_stp`|`out_stp`|`CPU Time`|
|[Bitwuzla (0.8.2)](https://github.com/bitwuzla/bitwuzla/releases/tag/0.8.2)|`bitwuzla`|Bit-Vector|`exec_bitwuzla`|`out_bitwuzla`|`solving_context::time_solve` (in ms)|

#### Output Interpretation

Contents of each output file are ordered by files of each script, separated in segments. Each segment consists 3 parts:
- Is the input formulae satisfiable? (`sat, unsat` or timeout messages)
- The smt-model of the formulae (only available if result is `sat`)
- Before the end of segment: Solver statistics, including **time consumption of solving** (Specially, time is written to a separated file `out_osmt_time` of OpenSMT)
- A line denotes the end of segment: `fin [file].smt2`

### Property Verification

Files in `/prop` are specifications and formulae of Table 3 and 4. To reproduce solving SMT2 files, enter the folder, first unzip the SMT2 and Cyclone files (requires at least 4GB of disk space):

```shell
unzip formulae.zip
```

Make sure all `.smt2` files are **at same directory** of `.sh` scripts. Then use `bash exec_[solver]_[floors].sh` for solving the set of formulae using particular solver (see table below for details). For instance, using MathSAT5 to verify 3-floors (requires `mathsat` be configured in `PATH`):

```shell
bash exec_ms_3.sh
```

This generates `out_ms3.txt` as output. All results **should be `unsat`**. Time consumption is also recorded. Notice there is a 2-hour timeout for solving every formulae. Some formulae can timeout, as shown in paper. 

#### Naming of Properties

Naming of both Cyclone specifications and SMT2 formulae are consists 4 segments `l[floors]_[config]_[properties]_[steps]` where:
- `[floors]` is the total number of floors
- `[config]` is either `stc` (for fixed configuration) or `dyn` (for dynamic configuration)
- `[properties]` consists of verified properties, where `l01` denotes Floor Reachability (FR) properties, and `m0123` denotes Direction Switching (DS) properties. 
- `[steps]` only exists for dynamic configuration files, which marks the number of steps (4, 8, 16, 32).

File extensions and suffix are explained at later section. 

### Scenario Testing

Files in `/scene` are 10 testing scenarios of Table 5 and 6. To reproduce, first enter the folder and unzip the SMT2 and Cyclone files (require at least 12GB of disk space):

```shell
# There are totally 6 zip files
# the quote is mandatory
unzip 'form*.zip'
```

Make sure all `.smt2` files are **at same directory** of `.sh` scripts. Then use `bash exec_[solver].sh` for solving the set of formulae using particular solver (see above table for details). For instance, using CVC5 (requires `cvc5` executable be configured in `PATH`):

```shell
bash exec_cvc5.sh
```

This generates a `out_cvc5.txt` which contains solving result (**expecting SAT**) and time consumption of execution. 

Note that it would take large memory consumption for some solvers, such as OpenSMT and Bitwuzla, when solving large SMT files (above 40 floors). 

### SMT2 File Suffix Explanations

The `smt2` files have different file suffix from different code-generation approaches. The following table explains the source. Each `.cyclone` specification generates the following 3 variations of SMT2 formulae:

|SMT2 Suffix|Compiler|Description|
|---|---|---|
|`.cyclone_gen.smt2`|Cyclone (Java)|Integer encoding (`QF_LIA` logic of SMT-LIB)|
|`.lia.smt2`|Cyclone (Rust)|Integer encoding (`QF_LIA` logic of SMT-LIB)|
|`.bv.smt2`|Cyclone (Rust)|Bit-Vector encoding (`QF_BV` logic of SMT-LIB)|



## Additional Instructions

The above instruction explains how to solve each pre-generated SMT2 file. The following section explains how to generate SMT2 formulae from cyclone specifications, and how to generate cyclone specifications from scripts. 

### Running Cyclone Specification

[See `example/README.md` for details](https://github.com/lucid-brndmg/elevator-cyclone-smt/tree/master/example) on running Cyclone specification online and locally.

### Generating SMT2 From Cyclone Specifications

There are 3 ways to generate SMT2 files from Cyclone specification, corresponds to 3 entries of the above table. Here we assume input file is `l3_stc.cyclone` (a 3-floor elevator in fixed configuration). 

#### Using Cyclone (Java)

##### Automatically (Recommended)

First set the correct folder of Cyclone to `CYCLONE_PATH` of `/cyclone-versions/cyclone-gen` (second line) Add the `cyclone-gen` script to `PATH`. 

Then, one can use this script to generate SMT2 formulae. The naming follows above suffix: 
```shell
cyclone-gen l3_stc.cyclone
```
Generates a `l3_stc.cyclone_gen.smt2` in integer encoding. 

##### Manually

First, to compile formulae from Cyclone (Java), one must set `option-generation="SMT2"` at beginning of each `.cyclone` file. Then similar to running:

```shell
# optionally use -Xss and -Xmx parameter to adjust memory allocation
java -jar /path/to/cyclone.jar l3_stc.cyclone
```

It generates a `l3_stc.cyclone.smt2.dump` file. Then one should convert the output to SMT-LIB file by:
```shell
# replace 'simplify' to 'assert' command
sed -i 's/simplify/assert/g' l3_stc.cyclone.smt2.dump
# insert extra check command to bottom of file
echo "\n(check-sat)(get-model)" >> l3_stc.cyclone.smt2.dump
# remove the .dump suffix
mv l3_stc.cyclone.smt2.dump l3_stc.cyclone.smt2
```

Finally solvers can be invoked for checking. For example using Z3:
```shell
z3 l3_stc.cyclone.smt2 -st
```

The output SMT2 file is in integer encoding. Note that it is very time-consuming for generating large amount of (typically above 45) floors.

#### Using Cyclone (Rust) with Integer Encoding

Option `option-generation` is NOT supported in the Rust version. Instead, it uses a command-line argument `--codegen out.smt2`. For instance:

```shell
# optionally use --stack-size <bits> to adjust stack size for large input
/path/to/cyclone-native l3_stc.cyclone --codegen l3_stc.smt2
```

Then `l3_stc.smt2` can be checked by Z3 or other solvers. The output SMT2 file is in integer encoding. Notice it is memory-consuming for generating 50-floors. If `cyclone-native` exit unexpectedly, set `--stack-size 536870912` to increase stack size. 

#### Using Cyclone (Rust) with Bit-Vector Encoding

Additionally, the Rust version supports automatic conversion for `int` to signed `bv`. For a 3-floor elevator, it takes `ceil(log2(3)) + 1 = 3` bits to correctly represent maximum possible integer (i.e, the floor) in specification. Hence, one can generate BV formulae by:

```shell
# optionally use --stack-size <bits> to adjust stack size for large input
/path/to/cyclone-native l3_stc.cyclone --codegen l3_stc.bv.smt2 --option-bv-int --option-bv-int-size 3
```

The resultant `l3_stc.bv.smt2` file then can be solved by BV solvers, such as STP and Bitwuzla. 

### Generating Cyclone Specifications

Code generation scripts are placed at `/scripts`. All scripts are written in JavaScript and **requires [Node.js](https://nodejs.org/en) runtime to be installed**. Brief description: 

- `liftblast.js` is for Cyclone model generation where parameters of `n`, `k`, etc... can be passed in as JSON format (see sourcecode) or manually changed in-need. 
- `manifest.js` is a library-purposed file containing basic information of directories of compilers and solvers. 
- `liftcase.js` generates Cyclone spec with SMT formulae of scenario testing (modify `outdir` variable for output directory).
- `liftprop.js` generates Cyclone spec with SMT formulae of property checking (modify `outdir` variable for output directory).

To use any above script, one may explicitly update corresponding variables (e.g. output directory) of the script. 

To generate a 3-floor static elevator model that initially idled at L1 with initial up and down request at L1, car request at L0 and path length of 26:
```shell
node ./scripts/liftblast.js '{"optN":3,"optK":26,"optPropCheck":false,"optDebug":false,"optEffect":false,"optOut":"example.cyclone","initFloor":1,"initReqUp":[1],"initReqDown":[1],"initReqCar":[0],"initMode":"I"}'
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
    "initPropLH": [0, 1], // FR property, ranges 0 to 1
    "initPropMS": [0, 1, 2, 3] // DS property, ranges 0 to 3
}
```

Notice if `optPropCheck = true`, then `initFloor, initMode, initReq*` are ignored, because in property checking mode. 