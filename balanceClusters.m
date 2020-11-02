function balancedClusters = balanceClusters(allClusters, data)
noOfClasses = unique(data(:,end));
balancedClusters = {};
b_index = 1;
for i = 1:size(allClusters,2)
    y = data(allClusters{i}.idxs, end);
    classes = unique(y);
    a = zeros(1,length(noOfClasses));
    index=1;
    for z=1:length(classes)
        a(1,index) = sum(y==classes(z));
        index= index + 1;
    end

    if max(a)-min(a) ~= 0
        for k=1:length(noOfClasses)
            if sum(y==noOfClasses(k)) == max(a)
                balancedClusters{1,b_index} = data(allClusters{i}.idxs,:);
                continue;
            end
        end
        for k=1:length(noOfClasses)
            if sum(y==noOfClasses(k)) ~= max(a)
                records = max(a) - sum(y==noOfClasses(k));
                toAdd = data(data(:,end)==noOfClasses(k),:);
                closestToCentroid = zscore(double(toAdd(:,1:end-1)))-allClusters{i}.centroids;
                closestToCentroid = sum(closestToCentroid,2);
                
                distances = unique(closestToCentroid);
                
                for d = 1:length(distances)
                    count =  sum(closestToCentroid == distances(d));
                    records = records - count;
                    if records >= 0
                        balancedClusters{1,b_index} = [balancedClusters{1,b_index}; toAdd(closestToCentroid == distances(d),:)];
                    end
                    if records < 0
                       break; 
                    end
                end
            end
        end
        b_index = b_index + 1;
    end
    
end


end