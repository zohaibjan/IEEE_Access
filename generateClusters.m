function genClusters = clusterData(Xtrain, Ytrain , params)
    noOfClusters = params.noOfClusters;
    totalClusters = 1;
    genClusters = {};
%     Xtrain = zscore(double(Xtrain));
%     Ytrain = double(Ytrain);
    for clusters=1:noOfClusters
        %% CLUSTERINGS
        % STANDARDIZE DATA BEFORE CLUSTERING
        if length(Xtrain) > clusters
            [clusterIds, C, sum, D] = kmeans(Xtrain, clusters, 'MaxIter', 2400);                                                                          % 'MaxIter',500, 'Replicates',5,  'dist','sqeuclidean'
            for j=1:clusters
                genClusters{totalClusters}.idxs = (clusterIds == j); % indexes of clusters
                genClusters{totalClusters}.centroids = C(j,:); % indexes of clusters
                genClusters{totalClusters}.balance = getBalance(Ytrain(clusterIds == j));
                y_prime = Ytrain(clusterIds == j);
                classes = unique(y_prime);
                noOfClasses = length(unique(y_prime));
                genClusters{totalClusters}.noOfClasses = noOfClasses;
                totalClusters = totalClusters + 1;
            end
        end
    end
end