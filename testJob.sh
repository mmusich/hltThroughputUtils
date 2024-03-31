#!/bin/bash -e

[ $# -eq 2 ] || exit 1

hltMenu="${1}"
jobLabel="${2}"

https_proxy=http://cmsproxy.cms:3128/ \
hltGetConfiguration "${hltMenu}" \
 --globaltag 140X_dataRun3_HLT_for2024TSGStudies_v1 \
 --data \
 --unprescale \
 --max-events 100 \
 --eras Run3 --l1-emulator uGT --l1 L1Menu_Collisions2024_v0_0_0_xml \
 --input /store/data/Run2023D/EphemeralHLTPhysics0/RAW/v1/000/370/293/00000/2ef73d2a-1fb7-4dac-9961-149525f9e887.root \
 > "${jobLabel}"_cfg.py

cat <<@EOF >> "${jobLabel}"_cfg.py
from customizeHLTforThroughputMeasurement import customizeHLTforThroughputMeasurement
process = customizeHLTforThroughputMeasurement(process)
@EOF

cmsRun "${jobLabel}"_cfg.py &> "${jobLabel}".log
