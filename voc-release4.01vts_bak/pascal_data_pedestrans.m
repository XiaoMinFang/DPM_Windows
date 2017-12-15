function [pos, neg] = pascal_data(cls, flippedpos, year)

% [pos, neg] = pascal_data(cls)
% Get training data from the PASCAL dataset.

pos_num = 924;

for i = 1:pos_num
    pos(i).im = sprintf('pos/%d.ppm', i);
    pos(i).x1 = 1;
    pos(i).y1 = 1;
    pos(i).x2 = 64;
    pos(i).y2 = 128;
    pos(i).flip = false;
    pos(i).trunc = 0;
end

neg_num = 100;
for i =1:neg_num
    neg(i).im = sprintf('neg/%d.jpg', i);
    neg(i).flip = false;
end

save([cachedir cls '_train_' year], 'pos', 'neg');