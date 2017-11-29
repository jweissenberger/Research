%% Iris Neural Network

% A Neural Network that classifies irises bases on dimensions of their
% features
% the columns of iris in order are: sepal length, sepal width, petal length
% petal width and then the species

%% Data Preperation
load fisheriris.mat;

% 1 = setosa, 2 = versicolor, 3 = verginica
% creates numeric lables for the network to predict

label = ones(1, 150);

for i = 51 : 150
    if i <=100
        label(1,i) = 2;
    else 
        label(1,i) = 3;
    end
end

% add the labels with the corresponding data
iris = [meas label'];

% a randomized test-train split, that outputs the indicies
[trainind, ~, testind] = dividerand(iris', .8, 0, .2);
trainind = trainind';
testind = testind';

% seperate the inputs from the outputs for the test and train data
X_train = trainind(:,1:4);
Y_trainVals = trainind(:,5);
% creates Y_train such that ther is an output for each node
Y_train = zeros(120, 3);
for i = 1 : 120
   if Y_trainVals(i) == 1
       Y_train(i, 1) = 1;
   end
   
   if Y_trainVals(i) == 2
       Y_train(i, 2) = 1;
   end
   
   if Y_trainVals(i) == 3
       Y_train(i, 3) = 1;
   end
end

% need to change these so that the network can read it
X_test = testind(:,1:4);
Y_testVals = testind(:,5);
% creates Y_train such that ther is an output for each node
Y_test = zeros(30, 3);
for i = 1 : 30
   if Y_testVals(i) == 1
       Y_test(i, 1) = 1;
   end
   
   if Y_testVals(i) == 2
       Y_test(i, 2) = 1;
   end
   
   if Y_testVals(i) == 3
       Y_test(i, 3) = 1;
   end
end
%% Define Hyperparameters
% This will be a 4 layer neural network, with two hidden layers

inputLayerSize = 4; % representing the 4 features 
outputLayerSize = 3; % representing the 3 kinds of iris
hiddenLayer1Size = 10;
hiddenLayer2Size = 10;


%% Randomly Initialize Weights and Biases

W12 = rand(inputLayerSize, hiddenLayer1Size);
b12 = rand(1, hiddenLayer1Size);
W23 = rand(hiddenLayer1Size, hiddenLayer2Size);
b23 = rand(1, hiddenLayer2Size);
W34 = rand(hiddenLayer2Size, outputLayerSize);
b34 = rand(1, outputLayerSize);



%% Forward Propagation

[Yout, z4, z3, z2] = ForwardProp( X_train, W12, b12, W23, b23, W34, b34 );


%% Back Propagation

% error in the output layer
delOut = Yout - Y_train;

% error in the third layer (second hidden layer)
del3 = ((W34)*delOut).*sigmoidGradient(z4);

% error in the second layer (first hidden layer)
del2 = ((W23)*del3).*sigmoidGradient(z3)';

% error in the first layer
del1 = ((W12)*del2).*sigmoidGradient(z2)';





