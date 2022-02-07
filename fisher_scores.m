% D - data matrix (columns are features)
% lbls - labels for the data (length = amount of rows in D)
function scores = fisher_scores(D, lbls)
  [nrow, ncol] = size(D);
  nclusters = length(unique(lbls));
  intra_class_var = zeros(nclusters, ncol);
  inter_class_var = zeros(nclusters, ncol);
  for i = 1:nclusters
    lbl = lbls(i);
    D_lbl = D(lbl == lbls,:);
    lbl_mean = mean(D_lbl);           % Cluster mean
    D_mean = mean(D);                 % Dataset mean
    p_lbl = sum(lbl == lbls) / nrow;  % Propotion of points with label
    lbl_var = var(D_lbl);             % Variances for cluster
    intra_class_var(i,:) = p_lbl * (lbl_mean - D_mean)^2;
    inter_class_var(i,:) = p_lbl * lbl_var;
  end
  scores = sum(intra_class_var) ./ sum(inter_class_var);
end
