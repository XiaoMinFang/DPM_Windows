% function warped = warppos(model, pos)
% 
% % warped = warppos(name, model, pos)
% % Warp positive examples to fit model dimensions.
% % Used for training root filters from positive bounding boxes.
% 
% globals;
% 
% pospath = 'E:\OPA_repos\data\TrainData\pos\pedestrian\dpm\64_40\list.txt';
% fid = fopen(pospath,'r+');
% 
% 
% fi = model.symbols(model.rules{model.start}.rhs).filter;
% fsize = model.filters(fi).size;
% pixels = fsize * model.sbin;
% heights = [pos(:).y2]' - [pos(:).y1]' + 1;
% widths = [pos(:).x2]' - [pos(:).x1]' + 1;
% numpos = length(pos);
% warped = cell(numpos);
% cropsize = (fsize+2) * model.sbin;
% posindex=1;
% for i = 1:numpos
% % while(~feof(fid))
%   fprintf('%s: warp: %d/%d\n', model.class, posindex, numpos);
% %   picname = fgetl(fid);
%   
%   im = imreadx(pos(i));
%   padx = model.sbin * widths(i) / pixels(2);
%   pady = model.sbin * heights(i) / pixels(1);
% % padx=1;pady=1;                %modify by xsl
% %   width = pos(i).x2 - pos(i).x1;
% %   height = pos(i).y2 - pos(i).y1;
% %   y_ex = int32(height*0.05);
% %   x_ex = int32(width*0.02);
% %   x1 = round(pos(i).x1-x_ex);
% %   x2 = round(pos(i).x2+x_ex);
% %   y1 = round(pos(i).y1-y_ex);
% %   y2 = round(pos(i).y2+y_ex);
%   
% %   imshow(im);
% %  rectangle('Position',[x1,y1,x2-x1,y2-y1],'EdgeColor','r');
% 
% %   window = subarray(im, y1, y2, x1, x2, 1);
%   warped{posindex} = double(imread(picname));
% %   warped{posindex} = imresize(window, cropsize, 'bilinear');
%   posindex = posindex+1;
% %   name = sprintf('pic2\\%d.jpg',i);
% %  imwrite(uint8(warped{i}),name);
% end
% fclose(fid);
% end


function warped = warppos(model, pos)

% warped = warppos(name, model, pos)
% Warp positive examples to fit model dimensions.
% Used for training root filters from positive bounding boxes.

globals;

fi = model.symbols(model.rules{model.start}.rhs).filter;
fsize = model.filters(fi).size;
pixels = fsize * model.sbin;
heights = [pos(:).y2]' - [pos(:).y1]' + 1;
widths = [pos(:).x2]' - [pos(:).x1]' + 1;
numpos = length(pos);
warped = cell(numpos);
cropsize = (fsize+2) * model.sbin;
index=1;
for i = 1:numpos
  fprintf('%s: warp: %d/%d\n', model.class, i, numpos);
  im = imreadx(pos(i));
  [h,w,c] = size(im);
  padx = model.sbin * widths(i) / pixels(2);
  pady = model.sbin * heights(i) / pixels(1);
  x1 = int32(round(pos(i).x1-padx));
  x2 = int32(round(pos(i).x2+padx));
  y1 = int32(round(pos(i).y1-pady));
  y2 = int32(round(pos(i).y2+pady));
%   imshow(im);
%  rectangle('Position',[x1,y1,x2-x1,y2-y1],'EdgeColor','r');

% window = subarray(im, y1, y2, x1, x2, 1);
if y1 <1
    y1=1;
%     continue;
end
if x1 <1
%     continue;
    x1=1;
end
if x2 > w
%     continue;
    x2=w;
end
if y2 > h
%     continue;
    y2=h;
end
  window = double(im(y1:y2,x1:x2,:));
%   if c==3
%       windowgray = rgb2gray(window);
%       
%   end
  warped{i} = imresize(window, cropsize, 'bilinear');
  jpgname = sprintf('E:/IPD/data/%d.jpg',index);
  imwrite(uint8(warped{i}),jpgname);
  index = index +1;
%   imshow(uint8(warped{i}))
 
end