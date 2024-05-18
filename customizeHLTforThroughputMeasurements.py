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

def customizeHLTforCMSHLT3196_baseline(process):
    process = customizeHLTforThroughputMeasurements(process)
    return process

def customizeHLTforCMSHLT3196_CCCLooseInAll(process):
    process = customizeHLTforThroughputMeasurements(process)
    process.HLTSiStripClusterChargeCutNone = cms.PSet(  value = cms.double( 1620.0 ) )
    return process

def customizeHLTforCMSHLT3196_CCCLooseInSiStripUnpacker(process):
    process = customizeHLTforThroughputMeasurements(process)
    process.hltSiStripRawToClustersFacility.Clusterizer.clusterChargeCut.refToPSet_ = 'HLTSiStripClusterChargeCutLoose'
    return process

def customizeHLTforCMSHLT3196_CCCLooseInRefToPSet(process):
    process = customizeHLTforThroughputMeasurements(process)

    def updateRefToPSet(module):
        ret = []
        for parName in module.parameterNames_():
            param = getattr(module, parName)
            if isinstance(param, cms.VPSet):
                for pset in param:
                    ret += updateRefToPSet(pset)
            elif isinstance(param, cms.PSet):
                ret += updateRefToPSet(param)
            elif parName == 'refToPSet_':
                if param.value() == 'HLTSiStripClusterChargeCutNone':
                    setattr(module, parName, 'HLTSiStripClusterChargeCutLoose')
        return ret

    for moduleDict in [
        process.psets_(),
        process.es_prefers_(),
        process.es_producers_(),
        process.es_sources_(),
        process.filters_(),
        process.producers_(),
        process.analyzers_(),
        process.switchProducers_(),
    ]:
        for moduleLabel_i in moduleDict:
            try:
                if getattr(process, moduleLabel_i).type_() == 'SiStripClusterizerFromRaw':
                    continue
            except:
                pass
            updateRefToPSet(getattr(process, moduleLabel_i))

    return process
