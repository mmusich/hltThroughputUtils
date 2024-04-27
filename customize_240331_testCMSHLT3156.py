import FWCore.ParameterSet.Config as cms
import os

from HLTrigger.Configuration.common import *

def customizeHLTforThroughputMeasurement(process):

    # update the HLT menu for re-running offline using a recent release
    from HLTrigger.Configuration.customizeHLTforCMSSW import customizeHLTforCMSSW
    process = customizeHLTforCMSSW(process)

    if hasattr(process, 'HLTAnalyzerEndpath'):
        del process.HLTAnalyzerEndpath

    # use the global tag for TSG studies
    from Configuration.AlCa.GlobalTag import GlobalTag as customiseGlobalTag
    process.GlobalTag = customiseGlobalTag(process.GlobalTag,
        globaltag = '140X_dataRun3_HLT_for2024TSGStudies_v1',
        conditions = 'L1Menu_Collisions2024_v0_0_0_xml,L1TUtmTriggerMenuRcd,,,9999-12-31 23:59:59.000'
    )

    # run over data from run 370293, skimmed with the L1 2024 v0.0.0 menu
    process.load('run370293_cff')

    # create the DAQ working directory for DQMFileSaverPB
    os.makedirs(f'{process.EvFDaqDirector.baseDir.value()}/run{process.EvFDaqDirector.runNumber.value()}', exist_ok=True)

    # run with 32 threads, 24 concurrent events, 2 concurrent lumisections, over all events
    process.options.numberOfThreads = 32
    process.options.numberOfStreams = 24
    process.options.numberOfConcurrentLuminosityBlocks = 2
    process.maxEvents.input = 1000

    # force the '2e34' prescale column
    if hasattr(process, 'PrescaleService'):
        process.PrescaleService.lvl1DefaultLabel = '2p0E34'
        process.PrescaleService.forceDefault = True

    # (do not) enable and unprescale all Paths and EndPaths
    #del process.PrescaleService

    # (do not) print a final summary
    process.options.wantSummary = True
    process.MessageLogger.cerr.enableStatistics = cms.untracked.bool(False)

    # (do not) print all messages
    #process.MessageLogger.cerr.INFO.limit = 1000000000

    # do not generate INFO messages
    #process.MessageLogger.cerr.threshold = "FWKINFO"

    # write a JSON file with the timing information
    if hasattr(process, 'FastTimerService'):
        process.FastTimerService.writeJSONSummary = True

    #process.DependencyGraph = cms.Service('DependencyGraph',
    #  fileName = cms.untracked.string('dependency.dot'),
    #  highlightModules = cms.untracked.vstring(),
    #  showPathDependencies = cms.untracked.bool(False)
    #)

    #from HLTrigger.Configuration.CustomConfigs import L1REPACK
    #process = L1REPACK(process, "uGT")

    # custosmise the HLT menu to use the old L1 seeds from the 2024 v0.0.0 menu
    seed_replacements = {
        ' OR L1_DoubleMu0_Upt6_SQ_er2p0': '',
        ' OR L1_DoubleMu0_Upt7_SQ_er2p0': '',
        ' OR L1_DoubleMu0_Upt8_SQ_er2p0': '',
    }
    for module in filters_by_type(process, 'HLTL1TSeed'):
        seeds = module.L1SeedsLogicalExpression.value()
        if any(seed in seeds for seed in seed_replacements):
            for old_seed, new_seed in seed_replacements.items():
                seeds = seeds.replace(old_seed, new_seed)
            module.L1SeedsLogicalExpression = cms.string(seeds)

    return process
