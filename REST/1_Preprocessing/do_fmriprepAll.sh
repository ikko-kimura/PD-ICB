#! /bin/bash

# fMRIPrep version 20.2.1 

dcm_dir=/gpfs/data/project/amano-g/kimura/PDRegistry/DICOM
bids_dir=/gpfs/data/project/amano-g/kimura/PDRegistry/data
tmp_dir=/home/ikimura/work/tmp

if [ ! -d ${bids_dir}/ ]; then
mkdir ${bids_dir}
mkdir /gpfs/data/project/amano-g/kimura/PDRegistry/fmriprep_wf
fi

for subj in `cat subj_list_hp04_3.txt`; do
#subj=091
echo "----------------------------------"
echo "!!! subj-${subj} !!!"
echo "----------------------------------"
# create the temporal directory
if [ ! -d ${tmp_dir} ]; then
mkdir ${tmp_dir}
mkdir ${tmp_dir}/data
fi

# dcm2bids
echo "dcm2bids..."
dcm2niix -f %p ${dcm_dir}/PD${subj}
mkdir ${bids_dir}/sub-${subj}
mkdir ${bids_dir}/sub-${subj}/anat
mkdir ${bids_dir}/sub-${subj}/func
cp ${dcm_dir}/PD${subj}/T1_Vol*.json ${bids_dir}/sub-${subj}/anat/sub-${subj}_T1w.json
cp ${dcm_dir}/PD${subj}/T1_Vol*.nii ${bids_dir}/sub-${subj}/anat/sub-${subj}_T1w.nii
cp ${dcm_dir}/PD${subj}/fMRI_Resting_10min_psy.json ${bids_dir}/sub-${subj}/func/sub-${subj}_task-rest_bold.json
cp ${dcm_dir}/PD${subj}/fMRI_Resting_10min_psy.nii ${bids_dir}/sub-${subj}/func/sub-${subj}_task-rest_bold.nii
cp -r ${bids_dir}/sub-${subj} ${tmp_dir}/data

# run fmriprep
singularity run --cleanenv /home/ikimura/fmriprep-20.2.1.simg \
${tmp_dir}/data ${tmp_dir}/output \
participant \
--participant-label ${subj} --fs-license-file /home/ikimura/freesurfer/license.txt --dummy-scans 4 --use-aroma --cifti-output --output-spaces MNI152NLin6Asym:res-2 MNI152NLin2009cAsym:res-2 fsaverage:den-10k func --nthreads 24 --omp-nthreads 24

# copy the data
cp -r -n ${tmp_dir}/output /gpfs/data/project/amano-g/kimura/PDRegistry
cp -r -n /home/ikimura/work/fmriprep_wf/single_subject_${subj}_wf /gpfs/data/project/amano-g/kimura/PDRegistry/fmriprep_wf
rm -r ${tmp_dir}
rm -r /home/ikimura/work/fmriprep_wf/single_subject_${subj}_wf
echo "----------------------------------"
done
