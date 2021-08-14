#!/bin/bash
source /cvmfs/cms.cern.ch/cmsset_default.sh

sig=$1
massX=$2
icat=$3

truth=$4
date="18_01_2021"
datacard_folder="/afs/cern.ch/work/k/kmenon/CMSSW_10_2_13/src/BkgOnlyBiasTest"
datacard=cms_HHbbgg_datacard_${sig}${massX}_${date}_2016_2017_2018
NGEN=1000
mu_inj=0.0
echo $mu_inj
#rMin=-10
#rMax=$((2*$mu_inj+6))
seed0=$5
seed1=$6


    CAT=DoubleHTag_${icat}_13TeV
    cd /afs/cern.ch/work/k/kmenon/CMSSW_10_2_13/src
    eval `scramv1 runtime -sh`
    cd $datacard_folder
    
    pdfidx=pdfindex_$CAT
    SETUP=${CAT}.${sig}_X${massX}_${date}.t$truth.GENSEED${seed0}
    GENERATE=higgsCombine${SETUP}.GenerateOnly.mH125.${seed0}.root
    TOYS=higgsCombineTest.GenerateOnly.${SETUP}.${seed0}.root
    echo $SETUP
    
    GENERATING1="combine ${datacard}_${CAT}_wIntegral.root -M GenerateOnly -m 125 --setParameters $pdfidx=$truth --expectSignal $mu_inj -t $NGEN --saveToys -n ${SETUP} --freezeParameters $pdfidx,rgx{.*} -s ${seed0} --toysFrequentist"
    echo $GENERATING1
    eval $GENERATING1

    mv $GENERATE $TOYS
    echo "generated " $TOYS
    MLFITTING1="combineTool.py ${datacard}_${CAT}_wIntegral.root -M MultiDimFit -m 125 --expectSignal $mu_inj --toysFile $TOYS --cminDefaultMinimizerStrategy 0 -n ${SETUP}_envelop -t $NGEN --saveFitResult --saveSpecifiedIndex $pdfidx -P r --setParameterRanges r=-5,5 --freezeParameters allConstrainedNuisances -s ${seed1} --job-mode condor --task-name condor-${SETUP} --sub-opts='+JobFlavour="tomorrow"' --job-dir $datacard_folder X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 shapeBkg_bkg_mass_ch1_${CAT}_integral_extended,shapeBkg_bkg_mass_ch1_${CAT}_integral"
    echo ${MLFITTING1}
    combineTool.py ${datacard}_${CAT}_wIntegral.root -M MultiDimFit -m 125 --expectSignal 0 --toysFile ${TOYS} --cminDefaultMinimizerStrategy 0 -n ${SETUP}_envelop -t ${NGEN} --saveSpecifiedIndex $pdfidx -P shapeBkg_bkg_mass_ch1_${CAT}__norm --freezeParameters r,rgx{.*},MH --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --saveSpecifiedFunc shapeBkg_bkg_mass_ch1_${CAT}_integral_extended,shapeBkg_bkg_mass_ch1_${CAT}_integral -s ${seed1} --job-mode condor --task-name condor-${SETUP} --sub-opts='+JobFlavour="tomorrow"' --job-dir ${datacard_folder}
    #rm -f $TOYS
    echo "fitted $pdfidx toy with envelop"
