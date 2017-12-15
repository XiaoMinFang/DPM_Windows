function [pos, neg] = pascal_data(cls, flippedpos, year)

% [pos, neg] = pascal_data(cls)
% Get training data from the PASCAL dataset.

setVOCyear = year;
globals;                                     %设置全局变量在整个代码中使用        
pascal_init;

if nargin < 2
    flippedpos = false;
end

try
    load([cachedir cls '_train_' year]);
catch
    % positive examples from train+val
    pos = [];
    numpos = 0;
    %for i = 1:length(ids);
    posnum = 2859;%9098
%     scalar = [0.2 0.17 0.15 0.012 0];
    scalar = [0 0.01 0.07 0.12 0.15];
%     betterPath = 'E:\CPC\data\TrainSamples\pos_sample.txt';
    betterPath = 'E:\IPD\pos_samples\pos_sample_half2.txt';
    fp = fopen(betterPath,'r');
    while(~feof(fp))
        str = fgetl(fp);
%         str = deblank(str);
%         S = regexp(str,'\s+','split');
%         imNo = str2num(S{1,1});
%         imBetterName = sprintf('%d.jpg',imNo);
%         imBetterName = [betterPath imBetterName];
%         imname = char(S{1,2});
%         if ~exist(imBetterName)
%             continue;
%         end
% %         mid_x = str2num(S{1,2});
% %         mid_y = str2num(S{1,3});
% %         w_harf = str2num(S{1,4});
% %         h_harf = str2num(S{1,5});
        im = imread(str);
%         imshow(im);
        [h,w,c] = size(im);
        xmin = w/4 ;             %(w/3)
        xmax = 3*w/4;              %(xmin*2)
        ymin = h/6;                 %(h/6)
        ymax = 5*h/6;                   %(5*h/6)
        width = xmax - xmin;                %
        height = ymax - ymin;               %
        ratio_h2w = 40/24;
        if height/width > ratio_h2w
            x_ex = (height - ratio_h2w*width)/2;
            xmin = xmin-x_ex;
            if xmin < 1
                xmin=1;
            end
            xmax = xmax+x_ex;
            if xmax > w
                xmax = w;
            end
        elseif height/width < ratio_h2w
            y_ex = (width*ratio_h2w - height)/2;
            ymin = ymin-y_ex;
            if ymin < 1
                ymin=1;
            end
            ymax = ymax+y_ex;
            if ymax > h
                ymax = h;
            end
        end



%         im_small = im(ymin:ymax,xmin:xmax,:);
%         imshow(im_small);
        
%         xmin = str2num(S{1,2});%((mid_x-w_harf));
%         ymin = str2num(S{1,4});%((mid_y-h_harf));
%         xmax = str2num(S{1,3});%((mid_x+w_harf));
%         ymax = str2num(S{1,5});%((mid_y+h_harf));
%         width = xmax-xmin;
%         height = ymax-ymin;
%         if height/width > 2.2
%             x_ex = (height/2 - width)/2;
%             xmin = xmin - x_ex;
%             xmax = xmax + x_ex;
%             if xmin <1
%                 xmin = 1;
%             end
%             if xmax > w
%                 xmax=w;
%             end
%                 
%         end

        numpos = numpos+1;
        pos(numpos).im = str;%char(S{1,1});
        pos(numpos).x1 = xmin*1.0001;%str2num(S{1,2});
        pos(numpos).x2 = xmax*1.0001;%str2num(S{1,3});
        pos(numpos).y1 = ymin*1.0001;%str2num(S{1,4});
        pos(numpos).y2 = ymax*1.0001;%str2num(S{1,5});
        pos(numpos).flip = false;
        pos(numpos).trunc = 0;        
    end
    fclose(fp)
    neg = [];
    numneg = 1;

    fid = fopen('E:\DPM_train_code\neg_sample.txt','r');
    while ~feof(fid)
        tline = fgetl(fid);
        neg(numneg).im = tline;
        neg(numneg).flip = false;
        numneg = numneg + 1;
    end
    fclose(fid);
    
    %%%%%%%%%%%%%%%%%%%%
    save([cachedir cls '_train_' year], 'pos', 'neg');
end
