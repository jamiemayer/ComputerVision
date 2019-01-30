defDir = 'C:\Users\Jamie Mayer\Desktop\ComputerVisionAssignment\ComputerVisionAssignment\Animals_with_Attributes';
M = load ('predicate-matrix-binary.txt');
[c1, c2] = textread('classes.txt', '%u %s');
trainClasses = textread('trainclasses.txt', '%s');
testClasses = textread('testclasses.txt', '%s');
animals = dir('features/caffe/features/vgg19');
animals = {animals.name};
animals = animals(3:end);