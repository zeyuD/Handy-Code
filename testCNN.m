% Load the pre-trained AlexNet neural network.
net = alexnet;

% Directory containing the image data.
imageFolder1 = 'lg/spec_x';
imageFolder2 = 'lg/spec_y';

% Create an ImageDatastore to handle loading the images. 
% The 'IncludeSubfolders' option ensures it includes images from each subfolder.
imds = imageDatastore(imageFolder1, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
% Create the two image datastores
imds1 = imageDatastore(imageFolder1, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
imds2 = imageDatastore(imageFolder2, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Combine the datastores
combinedDatastore = combine(imds1, imds2);

% Use the readAndPreprocess function to read and preprocess the images
while hasdata(combinedDatastore)
    [files, file_info] = read(combinedDatastore);
    file1 = files(1,1);
    file2 = files(1,2);
    combinedImage = readAndPreprocess(file1, file2);
    % Your code here, e.g. add the combinedImage to a matrix, use it for training, etc.
end



% The image input size of AlexNet is 227x227.
inputSize = net.Layers(1).InputSize;

% Resize all images to the input size of the CNN
imds.ReadFcn = @(loc)imresize(imread(loc), inputSize(1:2));

% Split with 50% of data for training and 50% for testing.
[trainingSet, testSet] = splitEachLabel(imds, 0.5, 'randomized');

% Replace the last three layers of the pre-trained network with new layers that are
% suitable for this problem.
layersTransfer = net.Layers(1:end-3);
numClasses = numel(categories(trainingSet.Labels));
layers = [layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

% Train the network.
opts = trainingOptions('sgdm', ...
    'ExecutionEnvironment', 'gpu', ... % use GPU for training
    'MiniBatchSize',16, ...
    'MaxEpochs',30, ...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress');
netTransfer = trainNetwork(trainingSet, layers, opts);

% Use the trained network to classify the test images.
predictedLabels = classify(netTransfer, testSet);

% Calculate the classification accuracy on the test set. Accuracy is the fraction of
% labels that the network predicts correctly.
accuracy = sum(predictedLabels == testSet.Labels)/numel(testSet.Labels)

% Create confusion matrix
figure("Position",[100,100,600,400]);
C = confusionmat(testSet.Labels, predictedLabels);
label = ["0","1","2","3","4","5","6","7","8","9"];
label = categorical(label);
cm = confusionchart(C,label);
cm.Normalization = 'row-normalized';
xlabel("Predicted Key");
ylabel("Clicked Key");


function out = readAndPreprocess(file1, file2)
    % Read the images
    img1 = file1{:,:,:};
    img2 = file2{:,:,:};

    % Convert to grayscale
    img1_gray = rgb2gray(img1);
    img2_gray = rgb2gray(img2);

    % Combine into a single 2-channel image
    out = cat(3, img1_gray, img2_gray);
end

