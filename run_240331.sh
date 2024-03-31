#!/bin/bash -e

[ $# -eq 2 ] || exit 1

hltMenu="${1}"
jobLabel="${2}"
runNumber=370293

run() {
  rm -rf run"${runNumber}"
  ${2}/benchmark "${1}" -E cmsRun -r 4 -j 8 -t 32 -s 24 -e -1 -g 1 -n --no-cpu-affinity -l "${3}" -k resources.json --tmpdir tmp |& tee "${3}".log
  ~/scripts/merge.py "${3}"/step*/pid*/resources.json > "${3}".json
}

https_proxy=http://cmsproxy.cms:3128/ \
hltConfigFromDB --configName "${hltMenu}" > "${jobLabel}"_cfg.py

cat <<@EOF >> "${jobLabel}"_cfg.py
from customizeHLTforThroughputMeasurement import customizeHLTforThroughputMeasurement
process = customizeHLTforThroughputMeasurement(process)
@EOF

edmConfigDump "${jobLabel}"_cfg.py > "${jobLabel}"_dump.py

for ntry in {00..02}; do

  jobDirPrefix="${jobLabel}"-"${CMSSW_VERSION}"-"${ntry}"

  ## CPU
  export CUDA_VISIBLE_DEVICES=
  run "${jobLabel}"_dump.py ./patatrack-scripts.cpu "${jobDirPrefix}"-cpu
  run "${jobLabel}"_dump.py ./patatrack-scripts     "${jobDirPrefix}"-cpu-vanilla

  ## GPU (NO MPS)
  unset CUDA_VISIBLE_DEVICES
  run "${jobLabel}"_dump.py ./patatrack-scripts.gpu "${jobDirPrefix}"-gpu
  run "${jobLabel}"_dump.py ./patatrack-scripts     "${jobDirPrefix}"-gpu-vanilla

  ## GPU MPS
  unset CUDA_VISIBLE_DEVICES
  ./start-mps-daemon.sh
  sleep 1
  run "${jobLabel}"_dump.py ./patatrack-scripts.gpu "${jobDirPrefix}"-gpu_mps
  run "${jobLabel}"_dump.py ./patatrack-scripts     "${jobDirPrefix}"-gpu_mps-vanilla
  ./stop-mps-daemon.sh
  sleep 1

done
unset ntry

rm -rf run"${runNumber}"
rm -rf __pycache__ tmp
