setup;

models = train_attribute_models;

%selectTestData;

getTestData;

[probs_class, probs_class_with_labels,  predictions] = compute_class_probs (M,animals,testClasses,c2,probLabels);

[acc ] = compute_accuracy( probs_class, ground_truth_class, animals, testClasses );


