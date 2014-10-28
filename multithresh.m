function thresh = multithresh(im, nbrclass)
%
% Multimodal image thresholding using cluster orgainzation from the image
% histogram. This program is an implementation of:
%   A.Z. Arifin and A. Asano, "Image segmentation by histogram thresholding
%   using hierarchical cluster analysis," Pattern Recognition Letters,
%   Vol. 27, No. 13, pp. 1515-1521, Oct. 2006.
%
% Inputs:
%   im: the input gray-scale image
%   nbrclass: number of classes for the output
%
% Output:
%   thresh: a vector of nbrclass-1 thresholding values [T1 T2 ... Tn].
%           The image can thus be segmented with [0..T1], [T1+1..T2],
%           ..., [Tn+1..255] intensity ranges.
%
%
% Copyright (c), Yuan-Liang Tang
% Associate Professor
% Department of Information Management
% Chaoyang University of Technology
% Taichung, Taiwan
% http://www.cyut.edu.tw/~yltang
% 
% Permission is hereby granted, free of charge, to any person obtaining
% a copy of this software without restriction, subject to the following
% conditions:
% The above copyright notice and this permission notice should be included in 
% all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
%
% Created: Dec. 10, 2007
%

global pr;
[count z] = imhist(uint8(im));
pr = [z count];
k = 1;
while 1
  if k>size(pr,1)
    break;
  end
  if pr(k,2)==0
    pr(k,:) = [];
  else
    k = k+1;
  end
end
pr = [fix(pr(:,1)), pr(:,2)/prod(size(im))];

% Initialize cluster as a single nonempty graylevel
C = [(1:size(pr,1))', (1:size(pr,1))'];
dist = zeros(size(pr,1)-1,1);
for i=1:length(dist)
  dist(i) = intervar(C(i,:),C(i+1,:))*intravar(C(i,:),C(i+1,:));
end

for i=1:size(C,1)-nbrclass
  [v m] = min(dist);
  C(m,2) = C(m+1,2);
  C(m+1,:) = [];
  if m > 1
    dist(m-1) = intervar(C(m-1,:),C(m,:))*intravar(C(m-1,:),C(m,:));
  end
  if m==length(dist)
    dist(m) = [];
  else
    dist(m) = intervar(C(m,:),C(m+1,:))*intravar(C(m,:),C(m+1,:));
    dist(m+1) = [];
  end
end
thresh = pr(C(1:end-1,2),1)';


function x = P(C)
global pr;
x = 0;
for i=C(1):C(2)
  x = x + pr(i,2);
end


function x = intervar(C1, C2)
P1 = P(C1);
P2 = P(C2);
x = (m(C1)-m(C2))^2*P1*P2/(P1+P2)^2;


function x = intravar(C1, C2)
global pr;
M12 = M(C1,C2);
x = 0;
for i=C1(1):C2(2)
  x = x + (pr(i,1)-M12)^2*pr(i,2);
end
x = x/(P(C1)+P(C2));


function  x = m(C)
global pr;
x = 0;
for i=C(1):C(2)
  x = x + pr(i,1)*pr(i,2);
end
x = x/P(C);
  

function  x = M(C1, C2)
P1 = P(C1);
P2 = P(C2);
x = (P1*m(C1)+P2*m(C2))/(P1+P2);

