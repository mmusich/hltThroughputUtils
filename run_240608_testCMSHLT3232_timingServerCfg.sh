#!/bin/bash -e

[ $# -eq 1 ] || exit 1

jobLabel="${1}"
runNumber=381065
outDir=/fff/user/"${USER}"/output/hltThroughputUtils

run() {
  [ ! -d "${3}" ] || exit 1
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  printf " %s\n" "${3}"
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  rm -rf run"${runNumber}"
  ${2}/benchmark "${1}" -E cmsRun -r 4 -j "${4}" -t "${5}" -s "${6}" -e 40100 -g 1 -n --no-cpu-affinity -l "${3}" -k resources.json --tmpdir "${outDir}"/tmp --no-warmup |& tee "${3}".log
  ./merge_resources_json.py "${3}"/step*/pid*/resources.json > "${3}".json
  mv "${3}".log "${3}".json "${3}"
  cp "${1}" "${3}"
}

#https_proxy=http://cmsproxy.cms:3128/ \
#hltConfigFromDB --runNumber "${runNumber}" > "${jobLabel}"_cfg.py

#cp /gpu_data/store/data/Run2024E/EphemeralHLTPhysics/FED/run"${runNumber}"_cff.py .
cp missirol_CMSSW_14_0_8_MULTIARCHS_240608_testCMSHLT3232_test01_try0__20240608_165353_hlt_customised.py "${jobLabel}"_cfg.py

# ensure MPS is disabled at the start
./stop-mps-daemon.sh

for jobSubLabel in test01; do

  ### Intermediate configuration file
  cp "${jobLabel}"_cfg.py tmp.py
#  cat <<@EOF >> tmp.py
#
#process.load('run${runNumber}_cff')
#
#from customizeHLTforThroughputMeasurements import *
#process = customizeHLTforCMSHLT3232_${jobSubLabel}(process)
#@EOF

  ### Final configuration file (dump)
  edmConfigDump tmp.py > "${jobLabel}"_"${jobSubLabel}"_dump.py
  rm -rf tmp.py

  ### Throughput measurements (benchmark)
  for ntry in {00..00}; do

    jobDirPrefix="${jobLabel}"-"${jobSubLabel}"-"${CMSSW_VERSION}"-"${ntry}"

    ## GPU (no MPS)
    unset CUDA_VISIBLE_DEVICES
    run "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-gpu 8 32 24

    ## GPU MPS
    unset CUDA_VISIBLE_DEVICES
    ./start-mps-daemon.sh
    sleep 1
    run "${jobLabel}"_"${jobSubLabel}"_dump.py ./patatrack-scripts "${outDir}"/"${jobDirPrefix}"-gpu_mps 8 32 24
    ./stop-mps-daemon.sh
    sleep 1

  done
  unset ntry

done
unset jobSubLabel

rm -rf "${jobLabel}"*{cfg,dump}.py
rm -rf run"${runNumber}"
rm -rf run"${runNumber}"_cff.py
rm -rf __pycache__ tmp
