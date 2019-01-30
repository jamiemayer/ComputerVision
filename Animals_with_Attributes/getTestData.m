defDir = 'C:\Users\Amie Lou\Desktop\ComputerVisionAssignment\Animals_with_Attributes';
M = load ('predicate-matrix-binary.txt');
[c1, c2] = textread('classes.txt', '%u %s');
trainClasses = textread('trainclasses.txt', '%s');
testClasses = textread('testclasses.txt', '%s');

animals = dir('features/caffe/features/vgg19');
animals = {animals.name};
animals = animals(3:end);
models = cell(85,1);
ct = 0; %Keep Track on number of classifiers trained

for h = 1:85 % For Each SVM
    X=[]; %Clear X
    Y = []; %Clear Y
    for i = 1:50 % For Each Animal
    cd(defDir);
    cd('features/caffe/features/vgg19');    
    if ismember(animals(i), trainClasses)
           s = char(animals(i));
           cd(s)
           for j=1:50 % Take 50 random samples of each animal in training data
               files = dir(pwd);
               n = size(dir(pwd),1)-2;
               rand = randi(n,1);
               randFile = files(rand+2,1).name;
               X = [X;textread(randFile, '%f')'];
               label = strmatch(s,c2);
               label = M(label,h);
               Y = [Y;label];
           end
    end

    end
    models{h} = fitcsvm(X,Y);
    ct = ct+1
end
 cd(defDir);