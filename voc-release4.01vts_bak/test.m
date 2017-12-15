function test(name, model)
cls = model.class;
% load and display imag4
im = imread(name);
% im = rgb2gray(im);
im(:,:,1) = im(:,:,1);
im(:,:,2) = im(:,:,2);
im(:,:,3) = im(:,:,3);
% imshow(im)
% [m,n,z] = size(im);
% scale = 360/m;
% im = imresize(im,[360,n*scale]);
% clf;
% image(im);
% axis equal; 
% axis on;
% disp('input image');
% disp('press any key to continue'); pause;
% 
% disp('continuing...');
% %%
% % load and display model
% visualizemodel(model, 1:2:length(model.rules{model.start}));
% disp([cls ' model visualization']);
% disp('press any key to continue'); pause;
% disp('continuing...');
% % detect objects
im = imresize(im,0.5);

[dets, boxes] = imgdetect(im, model,-0.95);%-0.993 -0.7
top = nms(dets,1);
% top = dets;
clf;
if isempty(boxes)
    name
    fprintf('*********** has no target********\n');
    
else
showboxes(im, reduceboxes(model, boxes(top,:)));
end