% 

fname='vbm';
mkdir(fname)
dir1=[fname,'/ICD'];
dir2=[fname,'/nonICD'];
mkdir(dir1)
mkdir(dir2)

load('mp_202111.mat')
ID=Data(:,1);
ICD=Data(:,31);

subj_list=ID;
for i=1:length(subj_list)
    f=['data/smwc1sub-',num2str(subj_list(i)),'_T1w.nii'];
    copyfile(f,fname)
    clear i
end

subj_list=ID(ICD==1);
for i=1:length(subj_list)
     f=['data/smwc1sub-',num2str(subj_list(i)),'_T1w.nii'];
    copyfile(f,dir1)
    clear i
end

subj_list=ID(ICD==0);
for i=1:length(subj_list)
      f=['data/smwc1sub-',num2str(subj_list(i)),'_T1w.nii'];
    copyfile(f,dir2)
    clear i
end