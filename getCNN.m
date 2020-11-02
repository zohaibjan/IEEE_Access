function classifier = getCNN(X, y)
height = size(X,2);
y = categorical(y);
noOfClasses = length(unique(y));
for i = 1:size(X,1)
    data(:,:,:,i) = X(i,:)';
end

y = y';

layers = [
    imageInputLayer([height 1 1]) 
    convolution2dLayer(1,100,'Padding','same')
    reluLayer
    fullyConnectedLayer(384) 
    fullyConnectedLayer(384) 
    fullyConnectedLayer(384) 
    fullyConnectedLayer(noOfClasses) 
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm',...
    'MaxEpochs',500, ...
    'Verbose',false...
);

function stop=savetrainingplot(info)
stop=false;  %prevents this function from ending trainNetwork prematurely
if info.State=='done'   %check if all iterations have completed
% if true
        saveas(findall,'filename.png')  % save figure as .png, you can change this
end
end

classifier = trainNetwork(data, y', layers, options);

% predictedLabels = classify(net,X);

end


%% THE LAST GOOD TRY
% width = size(imgs,2);
% imgs = reshape(imgs, [1, width, 1, size(imgs,1)]);
% noOfClasses =  length(unique(labels));
% % miniBatchSize = 4024;
% 
% layers = [
%     imageInputLayer([1 9 1])
%     fullyConnectedLayer(9)
%     convolution2dLayer([1 1],100)
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(1, 'Stride', 1)
%     fullyConnectedLayer(noOfClasses)
%     softmaxLayer
%     classificationLayer
%     ];
% 
% options = trainingOptions( 'sgdm',...
%     'InitialLearnRate', 0.1,...
%     'MaxEpochs', 200 ...
%   );



% SOEMTHING THAT WORKED BUT WITH MNIST WITH GOOD ACCURACY
% imgs = reshape(imgs, [28, 28, 1, size(imgs,1)]);
% noOfClasses =  length(unique(labels));
% miniBatchSize = 4024;
% 
% layers = [
%     imageInputLayer([28 28 1])
%     convolution2dLayer(3,16,'Padding',1)
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(2,'Stride',2)
%     convolution2dLayer(3,32,'Padding',1)
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(2,'Stride',2)
%     convolution2dLayer(3,64,'Padding',1)
%     batchNormalizationLayer
%     reluLayer
%     fullyConnectedLayer(noOfClasses)
%     softmaxLayer
%     classificationLayer];
% 
% options = trainingOptions( 'sgdm',...
%     'MiniBatchSize', miniBatchSize...
%   );
% 
% 
% classifier = trainNetwork(imgs, labels, layers, options);



%% 
% % Cross varidation (train: 70%, test: 30%)
% cv = cvpartition(size(data,1),'HoldOut',0.3);
% idx = cv.test;
% Separate to training and test data
% dataTrain = data(~idx,:);
% dataTest  = data(idx,:);

%% WITHOUT FULLY CONNECTED
%     imageInputLayer([1 9 1])
%     convolution2dLayer([1 3],7, 'Stride', 1)
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer([1 3], 'Stride', 1)
%     convolution2dLayer([1 2],6)
%     batchNormalizationLayer
%     reluLayer
%     fullyConnectedLayer(noOfClasses)
%     softmaxLayer
%     classificationLayer
%     ];



%% JO CHAL GIA THA

% layers = [
%     imageInputLayer([1 9 1])
%     fullyConnectedLayer(9)
%     convolution2dLayer([1 1],9, 'Stride', 1)
%     batchNormalizationLayer
%     reluLayer
%     maxPooling2dLayer(1, 'Stride', 1)
%     convolution2dLayer([1 1],9)
%     batchNormalizationLayer
%     reluLayer
%     fullyConnectedLayer(noOfClasses)
%     softmaxLayer
%     classificationLayer
%     ];




%65%
% layers = [
%     imageInputLayer([1, width, 1])
%     convolution2dLayer([1],width)
%     maxPooling2dLayer([1 width])
%     batchNormalizationLayer
%     reluLayer
%     fullyConnectedLayer(noOfClasses)
%     softmaxLayer
%     classificationLayer
%     ];
