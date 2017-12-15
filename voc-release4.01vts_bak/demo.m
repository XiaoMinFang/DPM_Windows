% function demo()
% 
% load('E:\code\dpm\voc-release4.01vts\TrainVal\result\pede_final.mat');

 load('E:\DPM_train_code\TrainVal\result\pede_final.mat');
% load('E:\DPM\voc-release4.01vts_bak\TrainVal\result\pede_final.mat');

% load('E:\code\dpm\res\multitemplate\pede_final_144_80.mat');
%test('E:\data\cw\BSC\DPM\ALL\IMAGE\5150.jpg', model);



test('E:\1.jpg', model);

% for i=1:1:53
% testfile = sprintf('E:/样本采集/add5_背面/timg (%d).jpg',i);
%     if exist(testfile,'file')
%         test(testfile, model);
%     else
%         continue;
%     end
% end





% load('INRIA/inriaperson_final');
% test('1.jpg', model);

% load('VOC2007/bicycle_final');
% test('000084.jpg', model);


% disp('detections');
% disp('press any key to continue'); pause;
% disp('continuing...');

% % get bounding boxes
% bbox = bboxpred_get(model.bboxpred, dets, reduceboxes(model, boxes));
% bbox = clipboxes(im, bbox);
% top = nms(bbox, 0.5);
% 
% clf;
% showboxes(im, bbox(top,:));
% disp('bounding boxes');
% disp('press any key to continue'); pause;
