#!/bin/bash -e

[ $# -eq 1 ] || exit 1

jobLabel="${1}"
runNumber=381065
outDir=/fff/user/"${USER}"/output/hltThroughputUtils

run110() {
  [ ! -d "${3}" ] || exit 1
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  printf " %s\n" "${3}"
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  rm -rf run"${runNumber}"
  rm -rf buOutput/run000000
  rm -rf buBaseDir/run000000
  mkdir -p buOutput/run000000
  mkdir -p buBaseDir/run000000
  ${2}/benchmark "${1}" -E cmsRun -r 4 -j "${4}" -t "${5}" -s "${6}" -e 40100 -g 1 -n --no-cpu-affinity -l "${3}" -k resources.json --tmpdir "${outDir}"/tmp |& tee "${3}".log
  ./merge_resources_json.py "${3}"/step*/pid*/resources.json > "${3}".json
  mv "${3}".log "${3}".json "${3}"
  cp "${1}" "${3}"
}

run011() {
  [ ! -d "${3}" ] || exit 1
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  printf " %s\n" "${3}"
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  rm -rf run"${runNumber}"
  rm -rf buOutput/run000000
  rm -rf buBaseDir/run000000
  mkdir -p buOutput/run000000
  mkdir -p buBaseDir/run000000
  ${2}/benchmark "${1}" -E cmsRun -r 4 -j "${4}" -t "${5}" -s "${6}" -e 40100 -g 1 --no-numa-affinity --gpu-affinity --cpu-affinity -l "${3}" -k resources.json --tmpdir "${outDir}"/tmp |& tee "${3}".log
  ./merge_resources_json.py "${3}"/step*/pid*/resources.json > "${3}".json
  mv "${3}".log "${3}".json "${3}"
  cp "${1}" "${3}"
}

https_proxy=http://cmsproxy.cms:3128/ \
#hltConfigFromDB --runNumber "${runNumber}" > "${jobLabel}"_cfg.py
#cp /gpu_data/store/data/Run2024E/EphemeralHLTPhysics/FED/run"${runNumber}"_cff.py .

# config dump from /eos/cms/store/group/tsg/STEAM/timing_server/results/prod/missirol/CMSSW_14_0_7_patch1_MULTIARCHS_240601_testCMSHLT3137_test11_try0.20240601_101913
cp missirol_CMSSW_14_0_7_patch1_MULTIARCHS_240601_testCMSHLT3137_test11_try0__20240601_101913_hlt_customised.py "${jobLabel}"_cfg.py

# ensure MPS is disabled at the start
./stop-mps-daemon.sh

for jobSubLabel in test11 test12 test13 test14 test15 test16; do

  ### Intermediate configuration file
  cp "${jobLabel}"_cfg.py tmp.py
  cat <<@EOF >> tmp.py

#process.load('run${runNumber}_cff')

from customizeHLTforThroughputMeasurements import *
process = customizeHLTforCMSHLT3137_${jobSubLabel}(process)
@EOF

  ### Final configuration file (dump)
  edmConfigDump tmp.py > "${jobLabel}"_"${jobSubLabel}"_dump.py
  rm -rf tmp.py

  ### Throughput measurements (benchmark)
  for ntry in {00..00}; do

    jobDirPrefix="${jobLabel}"-"${jobSubLabel}"-"${CMSSW_VERSION}"-"${ntry}"

    ## GPU (no MPS)
    unset CUDA_VISIBLE_DEVICES
    run110 "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-n1g1c0-gpu 8 32 24

#    ## GPU MPS
#    unset CUDA_VISIBLE_DEVICES
#    ./start-mps-daemon.sh
#    sleep 1
#    run110 "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-n1g1c0-gpu_mps 8 32 24
#    ./stop-mps-daemon.sh
#    sleep 1
#
#    ## GPU (no MPS)
#    unset CUDA_VISIBLE_DEVICES
#    run011 "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-n0g1c1-gpu 8 32 24
#
#    ## GPU MPS
#    unset CUDA_VISIBLE_DEVICES
#    ./start-mps-daemon.sh
#    sleep 1
#    run011 "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-n0g1c1-gpu_mps 8 32 24
#    ./stop-mps-daemon.sh
#    sleep 1

  done
  unset ntry

done
unset jobSubLabel

rm -rf "${jobLabel}"*{cfg,dump}.py
rm -rf run"${runNumber}"
rm -rf run"${runNumber}"_cff.py
rm -rf __pycache__ tmp
