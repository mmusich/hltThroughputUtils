#!/bin/bash

# Run 380647, LS 191-194

#for lumi_i in {191..194}; do
#  for pd_i in {0..7}; do
#    dasgoclient -query "file run=380647 lumi=${lumi_i} dataset=/EphemeralHLTPhysics${pd_i}/Run2024D-v1/RAW"
#  done
#done
#unset lumi_i pd_i

convertToRaw -r 380647:191-380647:194 \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics0/RAW/v1/000/380/647/00000/273a88ce-097e-4cb7-9e27-f22772a70010.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics0/RAW/v1/000/380/647/00000/b83d2da3-8f07-4c2c-9fdf-9f86461c1271.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics1/RAW/v1/000/380/647/00000/391596c3-d86e-4b5c-bc0d-587bc4a328b6.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics1/RAW/v1/000/380/647/00000/5f622fbb-55ea-4d5b-ab19-6f99a5301ded.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics2/RAW/v1/000/380/647/00000/32e528ba-c6d9-4469-93b0-89f357c83846.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics2/RAW/v1/000/380/647/00000/6d9b89cd-2318-488a-ba70-b5f07a1c9cb6.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics3/RAW/v1/000/380/647/00000/e6fc96d2-4b3b-4a18-9cee-530aebbb3261.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics3/RAW/v1/000/380/647/00000/eb0d2b80-b588-4cba-9512-9cf49da11c22.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics4/RAW/v1/000/380/647/00000/9936fde6-2eef-4a06-9484-6f2f8305106a.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics4/RAW/v1/000/380/647/00000/fafb42a9-3ac7-4690-bcba-af12028b3d95.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics5/RAW/v1/000/380/647/00000/5e66c7cd-e9f8-4f5c-825a-8264e24859a7.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics5/RAW/v1/000/380/647/00000/ff576c03-27c7-4ab9-85bb-f0a04df7a23b.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics6/RAW/v1/000/380/647/00000/b7d8d958-9a75-49fd-be6b-613653be07d7.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics6/RAW/v1/000/380/647/00000/cbbfb353-738c-4200-a1fa-49d08ac6e875.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics7/RAW/v1/000/380/647/00000/5bd9819a-f38b-4129-b598-035aa2dd8d3e.root \
  root://eoscms.cern.ch//eos/cms/store/data/Run2024D/EphemeralHLTPhysics7/RAW/v1/000/380/647/00000/d93e0e4f-263f-458a-81ed-51f90c3e0d7e.root
