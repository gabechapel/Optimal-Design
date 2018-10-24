%% Testing

% Load parameters incase they are cleared
% load('mnist.mat')
% load('Dag_Chapel.mat')

% Cell array for storing tested results
solution{1} = []; solution{2} = []; solution{3} = []; solution{4} = []; 
solution{5} = []; solution{6} = []; solution{7} = []; solution{8} = [];
solution{9} = []; solution{10} = [];
% Cell array for storing right side of each classification
other = solution;

% Image array for performing DAG
test_images_test = double(images_test);

% Start with 9 vs. 0 and end with 1 vs. 0
for j = 10:-1:2
    for i = 1:j-1
        notSmall = find(test_images_test * A{i,j} - B{i,j} < 0); % not i
        notLarge = find(test_images_test * A{i,j} - B{i,j} > 0); % not j
        other{i} = test_images_test(notLarge,:); % store right side of 
%         classification for next iteration
        test_images_test = [other{i+1}; test_images_test(notSmall,:)]; % append 
%         left side of iteration to right side of previous iteration
    end
    solution{j-1} = other{i}; % add right side of final classification to next 
%     iteration
    solution{j} = [solution{j}; test_images_test];
    test_images_test = other{1}; % start over with new set = right side of 
%     first classification
end

% Find indices of solutions to compare with original
[check0, ia0, ib0] = intersect(images_test, solution{1}, 'rows');
[check1, ia1, ib1] = intersect(images_test, solution{2}, 'rows');
[check2, ia2, ib2] = intersect(images_test, solution{3}, 'rows');
[check3, ia3, ib3] = intersect(images_test, solution{4}, 'rows');
[check4, ia4, ib4] = intersect(images_test, solution{5}, 'rows');
[check5, ia5, ib5] = intersect(images_test, solution{6}, 'rows');
[check6, ia6, ib6] = intersect(images_test, solution{7}, 'rows');
[check7, ia7, ib7] = intersect(images_test, solution{8}, 'rows');
[check8, ia8, ib8] = intersect(images_test, solution{9}, 'rows');
[check9, ia9, ib9] = intersect(images_test, solution{10}, 'rows');

% Make a label array for the results
labelResult(ia0) = 0;
labelResult(ia1) = 1;
labelResult(ia2) = 2;
labelResult(ia3) = 3;
labelResult(ia4) = 4;
labelResult(ia5) = 5;
labelResult(ia6) = 6;
labelResult(ia7) = 7;
labelResult(ia8) = 8;
labelResult(ia9) = 9;

% Compare results with original
checkResult = labelResult'==labels_test;
badResult = find(checkResult == 0);
accuracy = (length(checkResult) - length(badResult))/length(checkResult);