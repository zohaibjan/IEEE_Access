function results = runTraining(p_name , params)
warning('off','all');

data = load(p_name);
data = [data.X , data.y];

%% Create CROSS VALIDATION FOLDS
numOfFolds = params.numOfFolds;
cvFolds = cvpartition(data(:,end), 'KFold', numOfFolds);
accuracy = [];

%% ITERATE OVER THE NUMBER OF FOLDS
for fold=1:numOfFolds
    classifierIndex = 1;
    classifiers = {};
    trainData = data(cvFolds.training(fold),:);
    testData = data(cvFolds.test(fold),:);
    
    trainX = trainData(:, 1:end-1);
    trainy = trainData(:, end);
    
    testX = testData(:, 1:end-1);
    testy = testData(:, end);
    
    
    
    allClusters = generateClusters(trainX, trainy, params);
    getBalanceClusters = balanceClusters(allClusters, [trainX, trainy]);
    
    
    
    for c=1:length(getBalanceClusters)
        X = getBalanceClusters{1,c}(:,1:end-1);
        y = getBalanceClusters{1,c}(:, end);
        classifiers{classifierIndex} = getCNN(X, y);
        classifierIndex = classifierIndex + 1;
    end
    
    accuracy(fold) = fusion(classifiers, testX, testy);
    
end

% end
results.accuracy = mean(accuracy);
results.stdDev = std(accuracy);
end


