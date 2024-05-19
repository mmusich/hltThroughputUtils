
Setup instructions
==================

The instructions are work in progress.
```bash
ssh hilton-c2b02-44-01
```

```bash
dirName=MY_TEST_DIR
cmsswRel=CMSSW_14_0_6_MULTIARCHS

export SCRAM_ARCH=el8_amd64_gcc12
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SITECONFIG_PATH="/opt/offline/SITECONF/local"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

kinit $(logname)@CERN.CH
ssh -f -N -D18081 $(logname)@cmsusr.cms

mkdir -p /fff/user/"${USER}"/"${dirName}"
cd /fff/user/"${USER}"/"${dirName}"

cmsrel "${cmsswRel}"
cd "${cmsswRel}"/src
cmsenv
scram b
cd "${OLDPWD}"

git clone git@github.com:missirol/hltThroughputUtils.git -o missirol -b master

cd hltThroughputUtils

git clone git@github.com:missirol/patatrack-scripts.git -o missirol -b master                 -- patatrack-scripts
git clone git@github.com:missirol/patatrack-scripts.git -o missirol -b hilton-c2b02-44-01_cpu -- patatrack-scripts.cpu
git clone git@github.com:missirol/patatrack-scripts.git -o missirol -b hilton-c2b02-44-01_gpu -- patatrack-scripts.gpu
```

Measurements
============

```
./run_240331.sh /users/missirol/test/dev/CMSSW_14_0_0/tmp/240331_ThroughputMeasurements/TimingTest_01/GRun/V3 test240331_GRunV79
```

`240414_testCMSHLT3156`
 ```
 ./run_240414_testCMSHLT3156.sh out_240414_testCMSHLT3156_d766c5c
 ```
 - Run 379416, LS 126-128 (1200 bunches, Run2024C).
 - 40100 events in input.
 - L1T: 2024-v1_0_0.
 - HLT: same as online (v1.0.9).


`240416_testCMSHLT3156`
 ```
 ./run_240416_testCMSHLT3156.sh out_240416_testCMSHLT3156_523e197
 ```
 - Same as "240414_testCMSHLT3156", but a different HLT menu and PS column.
 - HLT: `/online/collisions/2024/2e34/v1.1/HLT/V4` (V1.1).
   - ECAL-Tracker "windows" set to nominal.
 - PS column: "2p0E34".


`240419_testCMSHLT3156`
 ```
 ./run_240419_testCMSHLT3156.sh out_240419_testCMSHLT3156_1381685
 ```
 - Run 379530, LS 465-467 (1800b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.10/HLT/V3` (V1.0).
 - PS column: "2p0E34".
 - Goal: reproduce HLT-throughput measurement performed online (111 kHz, 190 FUs).

`240422_testCMSHLT3156`
 ```
 ./run_240422_testCMSHLT3156.sh out_240422_testCMSHLT3156_ee5c719
 ```
 - Same as `240419_testCMSHLT3156`, with small adjustments suggested by Andrea.
     - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
     - `source.maxBufferedFiles = 2` (like online).
     - Remove L1T-seed changes (should have literally no impact).
     - Run 379530, LS 465-467 (1800b, Run2024C).
     - HLT: `/cdaq/physics/Run2024/2e34/v1.0.10/HLT/V3` (V1.0).
 - Goal: confirm, or not, the results of `240419_testCMSHLT3156`.

`240423_testCMSHLT3156`
 ```
 ./run_240423_testCMSHLT3156.sh out_240423_testCMSHLT3156_310bb19
 ```
 - Run 379660, LS 425-430 (1800b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.10/HLT/V3` (V1.0).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: confirm, or not, the results of `240422_testCMSHLT3156`.

`240424_testCMSHLT3156`
 ```
 ./run_240424_testCMSHLT3156.sh out_240424_testCMSHLT3156_624d45b
 ```
 - Run 379866, LS 165-169 (1200b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.10/HLT/V5` (V1.0).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: confirm, or not, the results of previous measurements.

`240427_testCMSHLT3156`
 ```
 ./run_240427_testCMSHLT3156.sh out_240427_testCMSHLT3156_694bc83
 ```
 - Run 380030, LS 112-116 (2200b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.11/HLT/V2` (V1.0).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: confirm, or not, the results of previous measurements and the online measurement.

`240428_testCMSHLT3156`
 ```
 ./run_240428_testCMSHLT3156.sh out_240428_testCMSHLT3156_d86987f
 ```
 - Run 370293, LS 241-242 (2452b, Run2023D).
 - HLT: `/cdaq/physics/Run2023/2e34/v1.2.3/HLT/V3` (same as online).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: compare to the values observed online in 2023.

`240430_testCMSHLT3156`
 ```
 ./run_240430_testCMSHLT3156.sh out_240430_testCMSHLT3156_e1375f2
 ```
 - Run 380030, LS 112-116 (2200b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.11/HLT/V2` (V1.0).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: estimate impact of using hyper-threading in HLT-throughput measurements.
   - no explicit disabling of hyper-threading,
     just measurements with different number of jobs/threads/streams

`240501_testCMSHLT3156`
 ```
 ./run_240501_testCMSHLT3156.sh out_240501_testCMSHLT3156_00fb1f1
 ```
 - Run 380030, LS 112-116 (2200b, Run2024C).
 - HLT: `/cdaq/physics/Run2024/2e34/v1.0.11/HLT/V2` (V1.0).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: estimate impact of using hyper-threading in HLT-throughput measurements.
 - Different benchmark settings compared to "240430_testCMSHLT3156".
   - vanilla patatrack-scripts
   - no explicit disabling of hyper-threading,
     just measurements with different number of jobs/threads/streams

`240518_testCMSHLT3196`
 ```
 ./run_240518_testCMSHLT3196.sh out_240518_testCMSHLT3196_8308aec
 ```
 - Goal: test impact of possible changes discussed in CMSHLT-3196.
 - Run 380647, LS 191-194 (2340b, Run2024D).
 - Machine: `hilton-c2b02-44-01`.
 - Settings as close as possible to online.
   - HLT menu: same as online, i.e. `/cdaq/physics/Run2024/2e34/v1.1.4/HLT/V1`.
   - PS column: same as online, i.e. "1p8E34+ZeroBias+HLTPhysics" (no explicit customisation).
   - `source.maxBufferedFiles = 2`.
   - MPS enabled, multi-threading enabled.
   - Explicit GPU assignment to NUMA domains (modified version of patatrack-scripts).
 - 3 configurations tested in addition to baseline (see `customizeHLTforThroughputMeasurements.py`).
   - `CCCLooseInAll`: CCCNone set to 1620 (affecting every module using CCCNone).
   - `CCCLooseInSiStripUnpacker`: CCCLoose in `SiStripClusterizerFromRaw`.
   - `CCCLooseInRefToPSet`: CCCLoose in all `refToPSet_` using CCCNone except for `SiStripClusterizerFromRaw`.

 ```
 ./run_240518_testCMSHLT3196.sh out_240518_testCMSHLT3196_b44dc75
 ```
 - To test one more case ("CCCLooseInRefToPSetSubsetB"), where CCC is changed from None to Loose
   only in a small arbitrary subset of modules not used in "standard" triggers.
