#! /bin/bash

for subj in `cat subj_list_all.txt`; do
echo ${subj}
WD=/project/amano-g/kimura/PDRegistry/output/fmriprep/sub-${subj}/func
fslroi ${WD}/sub-${subj}_task-rest_space-MNI152NLin6Asym_res-2_desc-preproc_bold_sm_cl_3.nii.gz ${WD}/sub-${subj}_task-rest_space-MNI152NLin6Asym_res-2_desc-preproc_bold_sm_cl_3_rm.nii.gz 4 236
done
