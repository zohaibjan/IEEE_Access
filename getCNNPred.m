function preds = getCNNPred(net, X)
for i = 1:size(X,1)
    data(:,:,:,i) = X(i,:)';
end
preds = classify(net, data);
end