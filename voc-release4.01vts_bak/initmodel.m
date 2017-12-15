function model = initmodel(cls, pos, note, symmetry, sbin, sz)

% model = initmodel(cls, pos, note, symmetry, sbin, sz)
% Initialize model structure.
%
% If not supplied the dimensions of the model template are computed
% from statistics in the postive examples.

% pick mode of aspect ratios
h = [pos(:).y2]' - [pos(:).y1]' + 1;
w = [pos(:).x2]' - [pos(:).x1]' + 1;
xx = -2:.02:2;
filter = exp(-[-100:100].^2/400);
aspects = hist(log(h./w), xx);
aspects = convn(aspects, filter, 'same');
[peak, I] = max(aspects);
aspect = exp(xx(I));
% aspect = aspect;

% pick 20 percentile area

areas = sort(h.*w);
area = areas(floor(length(areas) * 0.2));
area = 24*40;
% area = 40*88;
% area = 40*80;
% area = 24*56;
%area = max(min(area, 5000), 3000);
%%%%motuoche
%  area=1200;

% pick dimensions
w = sqrt(area/aspect);
h = w*aspect;

if nargin < 3
  note = '';
end

% get an empty model
model = model_create(cls, note);
model.interval = 10;

if nargin < 4
  symmetry = 'N';
end

% size of HOG features
if nargin < 5
  model.sbin = 8;
else
  model.sbin = sbin;
end

% size of root filter
if nargin < 6
  sz = [round(h/model.sbin) round(w/model.sbin)];
  %sz=[4 4];
end

% sz = [6 6];

% add root filter
[model, symbol, filter] = model_addfilter(model, zeros([sz 32]), symmetry);

% start non-terminal
[model, Q] = model_addnonterminal(model);
model.start = Q;

% add structure rule deriving only a root filter placement
model = model_addrule(model, 'S', Q, symbol, 0, {[0 0 0]});

% set detection window
model = model_setdetwindow(model, Q, 1, sz);
