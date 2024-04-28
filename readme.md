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
 ./run_240428_testCMSHLT3156.sh out_240428_testCMSHLT3156_
 ```
 - Run 370293, LS 241-242 (2452b, Run2023D).
 - HLT: `/cdaq/physics/Run2023/2e34/v1.2.3/HLT/V3` (same as online).
 - PS column: same as online (i.e. "2p0E34+HLTPhysics"), with no explicit customisation.
 - `source.maxBufferedFiles = 2` (like online).
 - Goal: compare to the values observed online in 2023.
