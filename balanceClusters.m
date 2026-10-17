function balancedClusters = balanceClusters(allClusters, data)
%BALANCECLUSTERS Keep balanced clusters and fill class deficits without duplicates.
classes = unique(data(:, end));
balancedClusters = cell(1, numel(allClusters));
for i = 1:numel(allClusters)
    members = logical(allClusters{i}.idxs(:));
    base = data(members, :);
    if isempty(base)
        error('Research:InvalidCluster', 'Clusters must contain at least one row.');
    end
    counts = zeros(size(classes));
    for j = 1:numel(classes)
        counts(j) = sum(base(:, end) == classes(j));
    end
    target = max(counts);
    balancedClusters{i} = base;
    centroid = allClusters{i}.centroids;
    for j = 1:numel(classes)
        need = target - counts(j);
        candidates = data(~members & data(:, end) == classes(j), :);
        offsets = bsxfun(@minus, candidates(:, 1:end-1), centroid);
        [~, order] = sort(sum(offsets .^ 2, 2));
        count = min(need, size(candidates, 1));
        balancedClusters{i} = [balancedClusters{i}; candidates(order(1:count), :)];
    end
end
end
