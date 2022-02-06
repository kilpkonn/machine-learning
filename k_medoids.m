
% data - data matrix (columns are features)
% k - param k for function (how many classes)
% s - distance function
% epsilon - max change in centroids (distance) for stopping
function Out = k_medoids(data, k, s, epsilon)
  [rows, cols] = size(data);
  min_vals = min(data);
  max_vals = max(data);

  centroids = rand(k, cols) * diag(max_vals - min_vals) + repmat(min_vals, k, 1)
  labels = repmat(-1, k, 1);

  deltas = repelem(0, 100);
  deltas(1) = Inf;

  dists = zeros(rows, k);
  for i = 2:100
    for r = 1:rows
      for j = 1:k
        a = centroids(j, :);
        b = data(r, :);
        dists(r, j) = s(a, b);
      end
    end

    [~, centroid_idxes] = min(dists, [], 2);

    for j = 1:k
      % a = dists
      a = centroids
      new_centroid = medoid(data(centroid_idxes == j, :), s)
      deltas(i) = deltas(i) + s(new_centroid, centroids(j, :));
      centroids(j, :) = new_centroid;
    end

    if abs(deltas(i) - deltas(i - 1)) < epsilon
      break
    end
  end

  Out.clusters = centroid_idxes;
  Out.centroids = centroids;
end
