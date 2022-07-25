from subprocess import check_output

check_output("git reset --hard upstream/experimental", shell=True)
check_output('"C:\Program Files (x86)\BYOND\bin\dm.exe" ../baystation12.dme', shell=True)
#check_output("bash dm.sh ../baystation12.dme", shell=True)
#check_output('Set PATH=%PATH%;"C:\Program Files (x86)\BYOND\bin"; & timeout 1 & dm.exe ../baystation12.dme', shell=True)
