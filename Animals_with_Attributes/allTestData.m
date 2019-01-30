probLabels = zeros(85,m*10) % preallocate emtpy matrix of 85(features)by
                            % m*10 (m instances of 10 classes) 

groundTruthClass = cell(1,m*10);                            
                            
k=1
for i = 1:50 % For Each Animal in test classes
    cd(defDir); % Return to root
    cd('features/caffe/features/vgg19'); % Move to folder containing folders
                                         % of data instances, grouped by
                                         % class.
    
           if ismember(animals(i), testClasses) % If animal class is part
                                                % of test set.
           s = char(animals(i));
           cd(s); % Enter folder named after this class
           anDir = dir();
           for j=1:(size(dir,1))-2
               animal = textread(anDir(i+2).name)'; % read in selected file
               % compute probability of class being of label 1 for the 
               % selected feature.
               cd(defDir);
               attLabels = compute_attribute_probs(animal, models);
               cd('features/caffe/features/vgg19');
               cd(s);
               probLabels(:,k) = attLabels; % Add this probabilty to the
                                            % collection of probabilities
               ground_truth_class(1,k) = cellstr(s);
               k=k+1 % Increment iteration counter.
               j
           end
               
    end
end
cd(defDir);