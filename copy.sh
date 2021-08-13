#!/bin/bash
datacard_folder="/afs/cern.ch/work/k/kmenon/CMSSW_10_2_13/src/BiasStudy_NMSSM"
eos_folder="$EOS/bias_study/toys_NMSSM"

massX=$1
massY=$2

[ ! -d "$eos_folder/X${massX}" ] && mkdir "$eos_folder/X${massX}"
[ ! -d "$eos_folder/X${massX}/Y${massY}" ] && mkdir "$eos_folder/X${massX}/Y${massY}"

cd $datacard_folder

cp higgsCombine*X${massX}*Y${massY}*Multi*final* plot_Bias2.C "$eos_folder/X${massX}/Y${massY}"
ls "$eos_folder/X${massX}/Y${massY}"
