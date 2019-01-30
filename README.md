# ComputerVision

Assignment from second year AI project centered on Zero Shot Learning. Written in Matlab.

1. Introduction
In this report I shall give a description of the task that I have carried out and the methodologies that I have employed whilst doing so before finally giving a brief discussion of the results that I have achieved.
The problem that I have been tasked with is to implement a zero shot learning algorithm similar to that proposed by Christoph Lampert (Lampert, Nickisch and Harmeling 453-465) in order to classify an image of a specific animal into the correct animal class.
The general Idea with zero shot learning is to train a classifier on a set of training data but then to use the classifier to predict classes on data for which it has been given no training examples by using the predictors for the classes that it has been trained on. This is achieved by using a classifier for each attribute using images from the classes we have training data for, looking at the outputs on all classifiers and matching this up with a class (as we know which attributes the unseen classes have).

2. Methodology
I chose to use the training data extracted from a convolutional neural network. I made this decision because I have been extremely impressed with the power of convolutional neural networks during the course of this module where I have been exposed to them. I also felt that as these features were extracted from a 19 layer network, the features would be more accurate descriptors than the other options available to me.
	I imported the training data in a random sample of 50 images each. I did this for speed as training this amount of classifiers gets extremely computationally expensive and the more training instances given to the classifiers adds to this. This was a challenge as sacrificing the number of training instances could have an impact on accuracy later down the line and so I felt that this was the best number of training instances to begin with as it would still give 2,000 instances overall. Next I trained a Support Vector Machine (SVM) for each of the 85 attribute labels and used the posteriors on each of them so that I could use the posterior probability of an instance possessing a given attribute. I then stored them in an 85*1 cell array.
	Following this, I wrote a script selectTestData to select the test data whereby I took 5 instances from each class. The script then calls the compute_attribute_probs function, passing it one image at a time and all of the classifiers. It returns an 85*1 vector where position (i,1) is the probability that the image it was passed, possesses that attribute. The script then stores this in an 85*m matrix where m is the number of test instances being used and the first index represents a particular attribute. Finally the script generates a 1*m matrix that holds the true class names of each test instance.
	Following this, I wrote a function compute_class_probs which takes the binary predicate matrix, the list of all animals, the list of test classes and the matrix of attribute probabilities for each test instance as arguments. It then returns a 10*m matrix where m is the number of test instances such that position (i,j) is the probability that test instance j is of class i. It also returns the same matrix only 10*m+1 in size where the first column is the list of test classes, so that it is easy to see when looked at. Lastly this function returns a matrix called predictions, where it stores the class that the test instance has the highest probability of being a member of. This can be thought of as like an argmax function
	Finally, I wrote a function compute_accuracy that takes in the probability of being in each class for each test instance, the true classes of the test instances, the list of animals and the list of test classes as arguments and returns an overall accuracy figure. This function contains some redundancy of code in that I could have made it much easier for myself by passing it the class probabilities with the associated class names that was generated in the previous function. The reason I chose not to do this was due to my desire to follow the brief rigidly as I was uncertain if the code would subject to automated marking and did not want to overcomplicate this process. However it would be very easy to change this as the variables required are already present in the code.
	I also wrote a script that runs all of these other scripts and functions sequentially for ease of use.

3. Results
In my first attempt, using 50 test instances I got an overall accuracy of 64%. I was pleasantly surprised by this as I used a relatively low subset of the training data. One reason that I think that this may have happened could be down to the random selection of training data, choosing instances which are prototypical of their class and as such strongly highlight which attributes their class has and doesn’t have. This would suggest a degree of luck is a factor when taking random samples in smaller amount. To support this, as I was writing this report, I trained new SVMs with 5 test instances from each class and found I had 74% accuracy. After realising that I am required to use all testing data I ran everything again using the same classifiers and had an accuracy of 56%

4. Discussion
I think that if training times were not such a debilitating factor, I would have tried steps to further improve my accuracy, such as taking a bigger sample of training data, using preprocessing on my data and kernel/PCA methods. I feel that my goals were achieved and I am pleased with my highest accuracy of 74% however I am excited by the idea of implementing the steps mentioned above to see if I can improve this even further. 

5. References
Lampert, Christoph H., Hannes Nickisch, and Stefan Harmeling. "Attribute-Based Classification For Zero-Shot Visual Object Categorization". IEEE Transactions on Pattern Analysis and Machine Intelligence 36.3 (2014): 453-465. Web.

	
