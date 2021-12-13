%Load the new images as an image datastore. This very small data set contains only 75 images.
imds = imageDatastore('C:/Users/27676/Desktop/plants3','IncludeSubfolders',true, 'LabelSource','foldernames'); 

%Divide the data into training and validation data sets. Use 70% of the images for training and 30% for validation.
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

%There are now 39 training images and 33 validation images in this very small data set. Display some sample images
numTrainImages = numel(imdsTrain.Labels);
idx = randperm(numTrainImages,16);
I = imtile(imds, 'Frames', idx);
figure
imshow(I)

%Load the pretrained SqueezeNet network
net = squeezenet;

%Analyze the network architecture. The first layer, the image input layer, requires input images of size 224-by-224-by-3, where 3 is the number of color channels.
analyzeNetwork(net)
inputSize = net.Layers(1).InputSize

%Extract the layer graph from the trained network. then convert the list of layers in net.Layers to a layer graph.
lgraph = layerGraph(net); 

%Find the names of the two layers to replace. By using the findLayersToReplace function
[learnableLayer,classLayer] = findLayersToReplace(lgraph);
[learnableLayer,classLayer] 

%Replace the convolutional layer with a new convolutional layer with the number of filters equal to the number of classes
numClasses = numel(categories(imdsTrain.Labels))
newConvLayer =  convolution2dLayer([1, 1],numClasses,'WeightLearnRateFactor',10,'BiasLearnRateFactor',10,"Name",'new_conv');
lgraph = replaceLayer(lgraph,'conv10',newConvLayer);

%The classification layer specifies the output classes of the network. Replace the classification layer with a new one without class labels. trainNetwork automatically sets the output classes of the layer at training time.
newClassificatonLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,'ClassificationLayer_predictions',newClassificatonLayer);

%Train the Network
pixelRange = [-30 30];
imageAugmenter = imageDataAugmenter('RandXReflection',true, 'RandXTranslation',pixelRange,'RandYTranslation',pixelRange);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain,'DataAugmentation',imageAugmenter);

% use an augmented image datastore to resize the validation images.
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);

%Specify the training options. Set InitialLearnRate to a small value to slow down learning in the transferred layers that are not already frozen.
options = trainingOptions('sgdm','MiniBatchSize',11,'MaxEpochs',7,'InitialLearnRate',2e-4,'Shuffle','every-epoch','ValidationData',augimdsValidation,'ValidationFrequency',3,'Verbose',false,'Plots','training-progress');

%Train the network using the training data
netTransfer = trainNetwork(augimdsTrain,lgraph,options);

%Classify the validation images using the fine-tuned network
[YPred,scores] = classify(netTransfer,augimdsValidation);

%Display four sample test images with their predicted labels.
idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end

