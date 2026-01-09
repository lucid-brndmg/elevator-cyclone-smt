#!/usr/bin/env bash
D=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TOOLS="$D/tools"
JAVA="$TOOLS/jdk-11.0.2/bin"
NODE="$TOOLS/node-v20.19.6-linux-x64/bin"
CYCLONE="$TOOLS/cyclone1359"

# Linux
export LD_LIBRARY_PATH=$CYCLONE
# MacOS
export DYLD_LIBRARY_PATH=$CYCLONE

export PATH="$JAVA:$NODE:$TOOLS:$PATH"