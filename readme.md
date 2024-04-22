./run_240331.sh /users/missirol/test/dev/CMSSW_14_0_0/tmp/240331_ThroughputMeasurements/TimingTest_01/GRun/V3 test240331_GRunV79


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
