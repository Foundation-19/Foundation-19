#!/bin/bash
set -euo pipefail

tools/deploy.sh ci_test
mkdir ci_test/config

# shitcode because fuck you polariscode config grr
cp -r config/* ci_test/config/

#test config
cp tools/ci/ci_config.txt ci_test/config/config.txt

#throw extools into ldd
#cp libbyond-extools.so ~/.byond/bin/libbyond-extools.so
#chmod +x ~/.byond/bin/libbyond-extools.so
#ldd ~/.byond/bin/libbyond-extools.so

cd ci_test
DreamDaemon vorestation.dmb -close -trusted -verbose -params "log-directory=ci"
cd ..
cat ci_test/data/logs/ci/clean_run.lk
