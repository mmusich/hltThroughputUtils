import FWCore.ParameterSet.Config as cms
import fnmatch

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

def customizeHLTforCMSHLT3196_CCCLooseInRefToPSetSubset(process, moduleList):
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
            keepModule = True
            for (modulePattern_j, keepModule_j) in moduleList:
                if fnmatch.fnmatch(moduleLabel_i, modulePattern_j):
                    keepModule = keepModule_j
            if keepModule:
                updateRefToPSet(getattr(process, moduleLabel_i))

    return process

def customizeHLTforCMSHLT3196_CCCLooseInRefToPSetSubsetA(process):
    process = customizeHLTforThroughputMeasurements(process)
    process = customizeHLTforCMSHLT3196_CCCLooseInRefToPSetSubset(process, [
        ('*', True),
        ('hltSiStripRawToClustersFacility', False),
    ])
    return process

def customizeHLTforCMSHLT3196_CCCLooseInRefToPSetSubsetB(process):
    process = customizeHLTforThroughputMeasurements(process)
    process = customizeHLTforCMSHLT3196_CCCLooseInRefToPSetSubset(process, [
        ('*', False),
        ('HLTIter1PSetTrajectoryFilterIT', True),
        ('HLTIter2PSetTrajectoryFilterIT', True),
        ('HLTIter4PSetTrajectoryFilterIT', True),
        ('HLTPSetMuonCkfTrajectoryFilter', True),
        ('hltDisplacedhltIter4PixelLessLayerTriplets', True),
        ('hltDisplacedhltIter4PixelLessLayerTripletsForDisplacedTkMuons', True),
        ('hltDisplacedhltIter4PixelLessLayerTripletsForGlbDisplacedMuons', True),
        ('hltDisplacedhltIter4PixelLessLayerTripletsForTau', True),
        ('hltMixedLayerPairs', True),
    ])
    return process
