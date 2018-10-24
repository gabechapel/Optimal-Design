%% Training
close all; clear all;

% Add cvx files to path
addpath /Users/gabrielchapel/Downloads/cvx
addpath /Users/gabrielchapel/Downloads/cvx/structures
addpath /Users/gabrielchapel/Downloads/cvx/lib
addpath /Users/gabrielchapel/Downloads/cvx/functions
addpath /Users/gabrielchapel/Downloads/cvx/commands
addpath /Users/gabrielchapel/Downloads/cvx/builtins

% Load data
load('mnist.mat')

% Establish features
X0 = double(images(labels==0,:));
X1 = double(images(labels==1,:));
X2 = double(images(labels==2,:));
X3 = double(images(labels==3,:));
X4 = double(images(labels==4,:));
X5 = double(images(labels==5,:));
X6 = double(images(labels==6,:));
X7 = double(images(labels==7,:));
X8 = double(images(labels==8,:));
X9 = double(images(labels==9,:));
feat = {X0, X1, X2, X3, X4, X5, X6, X7, X8, X9};

% Set up LP
gamma = 1000.0; % Weighting variable
n = 784;
tic

% Train the data for each classifier
for i = 1:9
    for j = i+1:10
        feat1 = feat(i); % Feature of first object
        feat1 = [feat1{:,:}];
        feat2 = feat(j); % Feature of second object
        feat2 = [feat2{:,:}];
        m1 = length(feat1); % Length of first feature
        m2 = length(feat2); % Length of second feature
        cvx_begin
        cvx_precision low % Low precision for faster performance
            variables a(n) b u(m1) v(m2) % Set up variables for LP
            minimize norm(a) + gamma*(ones(1,m1)*u+ones(1,m2)*v) % Linear program
            subject to % Constraints
                feat1*a - ones(m1,1)*b >= ones(m1,1) - u;
                feat2*a - ones(m2,1)*b <= -(ones(m2,1) - v);
                u >= 0;
                v >= 0;
        cvx_end
        A{i,j} = a;
        B{i,j} = b;
    end
end
toc

% save DAG_Chapel A B