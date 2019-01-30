%1.0 Got training data with labels in for first SVM using 25 Samples

defDir = 'C:\Users\Amie Lou\Desktop\ComputerVisionAssignment\Animals_with_Attributes';
M = load ('predicate-matrix-binary.txt');
[c1, c2] = textread('classes.txt', '%u %s');
trainClasses = textread('trainclasses.txt', '%s');
testClasses = textread('testclasses.txt', '%s');

animals = dir('features/caffe/features/vgg19');
animals = {animals.name};
animals = animals(3:end);
X=[];
Y = [];


for i = 1:50
    cd(defDir);
    cd('features/caffe/features/vgg19');    
    if ismember(animals(i), trainClasses)
           s = char(animals(i));
           cd(s)
           for j=1:25
               files = dir(pwd);
               n = size(dir(pwd),1)-2;
               rand = randi(n,1);
               randFile = files(rand+2,1).name;
               X = [X;textread(randFile, '%f')'];
               label = strmatch(s,c2);
               label = M(label,1);
               Y = [Y;label];
           end
    end
end
 cd(defDir);

