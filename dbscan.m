% data - data matrix (columns are features)
% s - distance function
% n - minimum amount of core points
% r - neighborhood radius
function Out = dbscan(data, s, n, r)
  nrow = size(data, 1);
  clusters = zeros(nrow, 1);
  lbl = 1;

  for j = 1:nrow
    merged = false;

    if clusters(j) ~= 0
      continue  % Point is already clustered
    end

    % Create core
    cluster = [];
    for i = 1:nrow
      a = data(j, :);
      b = data(i, :);
      if s(a, b) < r
        cluster(length(cluster) + 1) = i;
      end
    end

    % Check if core contains enough points to form a cluster
    merged = length(cluster) > n;

    while merged
      merged = false;

      for i = 1:nrow
        % Skip if already in cluster
        if ismember(i, cluster)
          continue
        end

        % Check if point can be merged
        p = data(i,:);
        for idx = cluster
          c = data(idx,:);
          if s(p, c) < r
            cluster(length(cluster) + 1) = i;
            merged = true;
            break
        end
      end
    end
  end

  if length(cluster) > n
    clusters(cluster, 1) = lbl;
    lbl = lbl + 1;
  end
  Out.clusters = clusters;
end
