function [probs_attr] = compute_attribute_probs(image, models)

probs_attr = zeros(85,1); % preallocate 85*1 matrix for speed

for i = 1:85 %for each classifier/feature
    [label,scores] = predict(models{i},image); % Get label & class confidence
    assert(sum(scores) == 1); % Ensure probabilties of being either 0 or 1
                              % Sum to 1
    probs_attr(i,1) = scores(2); % store probabilty of being class 1 for
                                 % given feature.
end
