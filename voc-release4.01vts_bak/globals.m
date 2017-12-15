% Set up global variables used throughout the code

% setup svm mex for context rescoring (if it's installed)
if exist('./svm_mex601') > 0
  addpath svm_mex601\bin;
  addpath svm_mex601\matlab;
end

% dataset to use
if exist('setVOCyear') == 1
  VOCyear = setVOCyear;
  clear('setVOCyear');
else
  VOCyear = '2007';
end

% directory for caching models, intermediate data, and results
% cachedir = ['E:\youxin\TrainVal\VOCdevkit\result\2011\'];
% cachedir = ['E:\DPM\voc-release4.01vts_bak\TrainVal\result\'];

cachedir = ['E:\DPM_train_code\TrainVal\result\'];
if exist(cachedir) == 0
  system(['mkdir -p ' cachedir]);
  if exist([cachedir 'learnlog\']) == 0
    system(['mkdir -p ' cachedir 'learnlog\']);
  end
end

% directory for LARGE temporary files created during training
% tmpdir = ['E:\DPM\voc-release4.01vts_bak\TrainVal\largedat\' VOCyear '\'];
tmpdir = ['E:\DPM_train_code\TrainVal\largedat\' VOCyear '\'];

if exist(tmpdir) == 0
  system(['mkdir -p ' tmpdir]);
end

% should the tmpdir be cleaned after training a model?
cleantmpdir = true;

% directory with PASCAL VOC development kit and dataset
VOCdevkit = ['E:\DPM_train_code\VOCdevkit\'];
