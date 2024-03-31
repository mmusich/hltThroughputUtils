#! /bin/bash -e

#source /cvmfs/cms.cern.ch/cmsset_default.sh
#eval `scram runtime -sh`

CONFIGS="reference alpaka"
rm -rf run370293

export CUDA_VISIBLE_DEVICES=
for M in $CONFIGS; do
  N=${M}-cpu
  ./patatrack-scripts.cpu/benchmark ${M}.py -E cmsRunJE -r 4 -j 8 -t 32 -s 24 -e -1 -g 0 -n --no-cpu-affinity -l ${N} -k resources.json --tmpdir tmp |& tee ${N}.log
  rm -rf run370293
  ~/scripts/merge.py ${N}/step*/pid*/resources.json > ${N}.json
done

unset CUDA_VISIBLE_DEVICES
./start-mps-daemon.sh
for M in $CONFIGS; do
  N=${M}-gpu-mps
  ./patatrack-scripts.gpu/benchmark ${M}.py -E cmsRunJE -r 4 -j 8 -t 32 -s 24 -e -1 -g 1 -n --no-cpu-affinity -l ${N} -k resources.json --tmpdir tmp |& tee ${N}.log
  rm -rf run370293
  ~/scripts/merge.py ${N}/step*/pid*/resources.json > ${N}.json
done

./stop-mps-daemon.sh

rm -r __pycache__ tmp
