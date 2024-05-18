import FWCore.ParameterSet.Config as cms

def customizeHLTforThroughputMeasurements(process):

    # remove check on timestamp of online-beamspot payloads
    process.hltOnlineBeamSpotESProducer.timeThreshold = int(1e6)

    # same source settings as used online
    process.source.eventChunkSize = 200
    process.source.eventChunkBlock = 200
    process.source.numBuffers = 4
    process.source.maxBufferedFiles = 2

    # taken from hltDAQPatch.py
    process.options.numberOfConcurrentLuminosityBlocks = 2

    # write a JSON file with the timing information
    if hasattr(process, 'FastTimerService'):
        process.FastTimerService.writeJSONSummary = True

    return process
