function labels = getCNNPred(net, X)
%GETCNNPRED Preserve numeric category names returned by classify.
if isempty(X)
    error('Research:EmptyInput', 'Prediction input must contain samples.');
end
data = reshape(X.', size(X, 2), 1, 1, size(X, 1));
labels = numericLabels(classify(net, data));
end
