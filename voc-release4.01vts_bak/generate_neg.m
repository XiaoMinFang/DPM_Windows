clear
clc

%setVOCyear = year;
globals;
pascal_init;

im_bk = imread('E:/youxin1/CPC2_Final_1/bk.png');
[m,n,z]=size(im_bk);
cls = 'VTS';
pos = [];
numpos = 0;
posnum = 8808;
for i=8737:posnum
    %fprintf('%s: parsing positives: %d/%d\n', cls, i, posnum);
    xmlfile=sprintf('E:/youxin1/neg_2/xml/%d.xml',i);
    if exist(xmlfile,'file')
        rec =PASreadrecord(xmlfile);
        if rec.flag == 0
            continue;
        end
        clsinds = length(rec.objects);
        
        pos.im=sprintf('E:/youxin1/neg_2/image/%d.jpg',i);
        pos.neg = sprintf('E:/youxin1/neg_2/neg_image/%d.jpg', i');
        im = imread(pos.im);
        for j = clsinds(:)'
            bbox = rec.objects(j).bbox;
            pos.x1 = bbox(1);
            pos.y1 = bbox(2);
            pos.x2 = bbox(3);
            pos.y2 = bbox(4);
            
            xwidth = bbox(3) - bbox(1);
            yheight = bbox(4) - bbox(2);
            
            x = randi(1,1,[1, m - xwidth]);
            y = randi(1,1,[1, n - yheight]);
            
            im(bbox(2)+1:bbox(4)-1,bbox(1)+1:bbox(3)-1,:)=im_bk(y:y+yheight-2, x:x+xwidth-2,:);
        end
       % imshow(im);
       imwrite(im,pos.neg);
    end
end
    