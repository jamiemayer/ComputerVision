function [acc ] = compute_accuracy( probs_class, ground_truth_class, animals, testClasses )

cor = 0; % correct predictions
inc = 0; % incorrect predictions
acc = 0;
animal_indices = cell(10,1)
j =1;

for i = 1: 50 % for all classes
    if ismember(animals(i), testClasses) % If class as position i of all 
                                         % classes is a test classs
        s = char(animals(i));
        animal_indices(j) = cellstr(s)  % add a string containing class
                                        % name to animal index vector at
                                        % position j. This will hold as it
                                        % is the ordering used when test
                                        % data was loaded.
        j = j+1    
    end
end

for i = 1:size(probs_class,2) % for each test image
    [q,r] = max(cell2mat(probs_class(:,i))); % get max and index of max
                                             % in column.
    predClass = animal_indices(r);           % The index of the max will
                                             % coincide with the index
                                             % of a class in the animal
                                             % indices vector. This is 
                                             % The predicted class.
    if strmatch(predClass,ground_truth_class(1,i)) % If the predicted class
                                                   % matched the ground
                                                   % truth class then
                                                   % increment cor count
        cor = cor+1'
    else
        inc = inc+1;    % Else increment inc count.
    end
end

cor
inc

acc = cor/size(probs_class,2); % Accuracy is the number of correct
% predicitions divided by the cardinality of the test set used.

