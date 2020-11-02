function program = mainProgram()

% Problem = dataSetNames();                 % Get list of dataset names
addpath(genpath('P-Data'));
Problem = { 'ecoli', 'haberman',...
            'ionosphere', 'iris',  'pima_diabetec', ...
            'sonar', 'teaching' , 'wine' ...
}

%% Model SETTINGS
params.numOfFolds = 10;                   % Create CROSS VALIDATION FOLDS
params.maxClusters = 10;                  % For nth root of clustering
params.classifiers = {'ANN', 'SVM', 'KNN', 'DT', 'DISCR', 'NB'};
params.trainFunctionANN={'trainlm','trainbfg','trainrp','trainscg','traincgb','traincgf','traincgp','trainoss','traingdx'};
params.trainFunctionDiscriminant = {'pseudoLinear','pseudoQuadratic'};
params.kernelFunctionSVM={'gaussian','polynomial','linear'};

%% MAIN LOOP
params.noOfClusters = 5;

parfor i=1:length(Problem)
    p_name = Problem{i};
    disp(p_name);
    results = runTraining(p_name, params);
    saveResults(results, p_name);
end
end







