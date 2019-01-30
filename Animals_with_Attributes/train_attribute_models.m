function [ models ] = train_attribute_models(  )
% default directory, aka root directory, will need to be changed when run
% on a different machine. 
defDir = 'C:\Users\Jamie Mayer\Desktop\ComputerVisionAssignment\ComputerVisionAssignment\Animals_with_Attributes';
M = load ('predicate-matrix-binary.txt'); % Predicate Matrix containing
                                          % true feature labels for classes
[c1, c2] = textread('classes.txt', '%u %s');
trainClasses = textread('trainclasses.txt', '%s'); % load training classes
testClasses = textread('testclasses.txt', '%s'); % load testing classes

animals = dir('features/caffe/features/vgg19');
animals = {animals.name};
animals = animals(3:end); % all class folders
models = cell(85,1); % pre alocated cell array for models to save time
ct = 0; %Keep Track on number of classifiers trained

for h = 1:85 % For Each SVM
    X= []; %Clear X
    Y = []; %Clear Y
    for i = 1:50 % For Each Animal
    cd(defDir);
    cd('features/caffe/features/vgg19');    
    if ismember(animals(i), trainClasses) %If animal class is a training class
           s = char(animals(i));
           cd(s) %Enter the file with the name of this class
           for j=1:50 % Take 50 random samples of each animal in training data
               files = dir(pwd);
               n = size(dir(pwd),1)-2;
               rand = randi(n,1);
               randFile = files(rand+2,1).name; %select random image from training class
               X= [X;textread(randFile,'%f')']; %add features of image to training dataset
               label = strmatch(s,c2);
               label = M(label,h);
               Y = [Y;label]; %Get class label for specified feature.
           end
    end

    end
    model = fitcsvm(X,Y); %Pass SVM the training data & class labels
    models{h} = fitSVMPosterior(model); %train svms on posteriors
    ct = ct+1 %increment classifiers trained count.
end
 cd(defDir); % Return to root directory
end

