#!/bin/bash -e

[ $# -eq 1 ] || exit 1

jobLabel="${1}"
runNumber=379660

run() {
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  printf " %s\n" "${3}"
  foo=$(printf "%125s") && echo ${foo// /-} && unset foo
  rm -rf run"${runNumber}"
  ${2}/benchmark "${1}" -E cmsRun -r 4 -j "${4}" -t "${5}" -s "${6}" -e 40100 -g 1 -n --no-cpu-affinity -l "${3}" -k resources.json --tmpdir tmp |& tee "${3}".log
  ./merge_resources_json.py "${3}"/step*/pid*/resources.json > "${3}".json
  mv "${3}".log "${3}".json "${3}"
  cp "${1}" "${3}"
}

https_proxy=http://cmsproxy.cms:3128/ \
hltConfigFromDB --runNumber "${runNumber}" > "${jobLabel}"_cfg.py

cp /gpu_data/store/data/Run2024C/EphemeralHLTPhysics/FED/run"${runNumber}"_cff.py .

cat <<@EOF >> "${jobLabel}"_cfg.py

process.load('run${runNumber}_cff')

from customize_240507_testCMSHLT3156 import customizeHLTforThroughputMeasurement
process = customizeHLTforThroughputMeasurement(process)
@EOF

edmConfigDump "${jobLabel}"_cfg.py > "${jobLabel}"_dump.py

for ntry in {00..01}; do

  jobDirPrefix="${jobLabel}"-"${CMSSW_VERSION}"-"${ntry}"

  ## GPU (No MPS)
  unset CUDA_VISIBLE_DEVICES
  run "${jobLabel}"_dump.py ./patatrack-scripts "${jobDirPrefix}"-gpu-vanilla-j08t32s24 8 32 24
  sleep 1

done
unset ntry

rm -rf "${jobLabel}"_{cfg,dump}.py
rm -rf run"${runNumber}"
rm -rf run"${runNumber}"_cff.py
rm -rf __pycache__ tmp
