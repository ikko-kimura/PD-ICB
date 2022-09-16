#! /bin/bash

# little preparation for VBM
# Ikko Kimura, Osaka University, 2021/8/15 

for subj in `cat subj_list_all.txt`; do
echo "Processing for ... ${subj}"
matlab -nosplash -nodesktop -r "spm_segment('"${subj}"'); exit" 
done
