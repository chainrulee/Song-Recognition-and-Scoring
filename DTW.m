function [p,q,D] = DTW(A,B,type)





%% DTW building
Arange= size(A,2);
Brange=size(B,2);
if size(Arange,1)~=size(Brange,1)
    error('Error in dtw(): the dimensions of the two input signals do not match.');
end
% costs
phi = zeros(Arange,Brange); % use it to trace the line
D = inf(Arange,Brange);
D(1,1) = sqrt(sum(abs(A(:,1)-B(:,1)).^2));
if type == 2
for i = 2:Arange
    D(i,1) = sqrt(sum(abs(A(:,i)-B(:,1)).^2))+D(i-1,1);
    phi(i,1) = 1;
end
for j = 2:Brange
    D(1,j) = sqrt(sum(abs(A(:,1)-B(:,j)).^2))+D(1,j-1);
    phi(1,j) = 3;
end
for i = 2:Arange
    for j = 2:Brange
        [MIN,idx] = min([D(i-1,j),D(i-1,j-1),D(i,j-1)]);                
        D(i,j) = sqrt(sum(abs(A(:,i)-B(:,j)).^2))+MIN;
        phi(i,j) = idx;     % 1:up 2:up-left 3:left
    end
end

% DTW





% Traceback the routine from end to origin
p(1) = Arange;
q(1) = Brange;
pidx = Arange;
qidx = Brange;
index = 2;
while(pidx ~= 1 || qidx ~=1)
    if phi(pidx,qidx)==1
        pidx = pidx-1;
    elseif phi(pidx,qidx)==2
        pidx = pidx-1;
        qidx = qidx-1;
    else
        qidx = qidx-1;
    end
    p(index) = pidx;
    q(index) = qidx;
    index = index + 1;
end

elseif type == 1
D(2,2) = sqrt(sum(abs(A(:,2)-B(:,2)).^2));
phi(2,2) = 2;
D(3,2) = sqrt(sum(abs(A(:,3)-B(:,2)).^2))+D(1,1);
phi(3,2) = 1;
D(2,3) = sqrt(sum(abs(A(:,2)-B(:,3)).^2))+D(1,1);
phi(2,3) = 3;
for i = 3:Arange
    for j = 3:Brange
        [MIN,idx] = min([D(i-2,j-1),D(i-1,j-1),D(i-1,j-2)]);                
        D(i,j) = sqrt(sum(abs(A(:,i)-B(:,j)).^2))+MIN;
        phi(i,j) = idx;     % 1:up-up-left 2:up-left 3:left-left-up
    end
end

p(1) = Arange;
q(1) = Brange;
pidx = Arange;
qidx = Brange;
index = 2;
while(pidx ~= 1 || qidx ~=1)
    if phi(pidx,qidx)==1
        pidx = pidx-2;
        qidx = qidx-1;
    elseif phi(pidx,qidx)==2
        pidx = pidx-1;
        qidx = qidx-1;
    else
        pidx = pidx-1;
        qidx = qidx-2;
    end
    p(index) = pidx;
    q(index) = qidx;
    index = index + 1;
end

else
    error('wrong type')
    
end
% D(m,n) is what we find
D = D(Arange,Brange);

