% probLabels last parameter
function [probs_class, probs_class_with_labels,  predictions] = compute_class_probs (M,animals,testClasses,c2,prob)
testAttributes = zeros(85,10); % Preallocate test Attributes matrix for
                               % speed.
j =1; % Column Index
n = size(prob,2); % set how many images we have probabilities for
probs_class_with_labels = cell(10,n); % 10 by n matrix each row will hold the probability
                          % of a specific image being of a specific class
                          % each column vector represents an image.
predictions = cell(size(prob,2),1) %Preallocate n * 1 matrix to hold class
                                    % prediction
for i = 1:50   % For each animal class
    if ismember(animals(i), testClasses) % if class is a membr of test set.
        s = char(animals(i)); % s = name of that animal class
        index = strmatch(s,c2); % get index of said class in predicate matrix
        testAttributes(:,j) = M(index,:); % Bring in attributes for each feature
                                          % of that test class
        probs_class_with_labels(j) = cellstr(s);      % label first column with class names
                                          % For visualisation
        j = j+1;    % Increment column index.
    end
    
end    

for i = 1:size(prob,2) % For each image
    for j = 1:10 % For each class
        p = 1; % p initialised to 1 as we are finding the product of the
               % probabilities so cannot initialise to zero. 
        for k = 1:85 % For each feature
            if testAttributes(k,j) == 1 % If class j has feature k(i.e label = 1)
                p = p*prob(k,i); % p(class j|x) = total p so far * p(feature k = 1|x)
            else % if class k does not have feature k (i.e label = 0)
                p = p*(1-(prob(k,i))); %p(class j|x) = total p so far * p(feature k = 0)|x)
            end
        end
        
        probs_class_with_labels(j,i+1)= num2cell(p);% Concatenate the probability column
                                        % vectors for each image.
        
    end
end
    probs_class = probs_class_with_labels(:,2:end); % probs class without class labels at side.

% produce a n*1 vector of predictions where pos(n,1) is a string with the 
% name of the predicted class.

for i =2:size(probs_class_with_labels,2) % start at 2 as the first column vector is 
                             % a list of class names
   [q,r] = max(cell2mat(probs_class_with_labels(:,i)));
   predictions(i-1,1) = (probs_class_with_labels(r));
end
    
end

