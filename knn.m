% D - Data matrix
% lbls - labels vector
% s - distance function
% point - point to classify
% k - Amount of nearest neighbours to consider
% return label for point
function lbl = knn(D, lbls, s, k, point)
  [nrow, ncol] = size(D);
  distances = zeros(nrow, 1);
  for i = 1:nrow
    other = D(i,:);
    distances(i,1) = s(point, other);
  end

  sorted_dists = sort(distances);
  k_dist = sorted_dists(k, 1);
  k_nearest_lbls = lbls(distances <= k_dist); % Note that there may be more than k
  
  lbl = mode(k_nearest_lbls);
end
