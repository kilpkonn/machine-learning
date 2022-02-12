
function Out = entropy_decision_criteria(D, lbls, n_buckets)
  if nargin < 3
    n_buckets = 10;
  end

  min_vals = min(D);
  max_vals = max(D);
  [nrow, ncol] = size(D);

  % First row is entropy decrease upon splitting
  % Second row is decision points value
  % Columns respond to columns in D
  decision_options = zeros(2, ncol);

  for col_idx = 1:ncol
    min_val = min_vals(col_idx);
    max_val = max_vals(col_idx);
    entropies = zeros(1, n_buckets);
    for i = 1:n_buckets
      decision_point = min_val + (max_val - min_val) / n_buckets * i;
      D_left = D(:,col_idx) <= decision_point;
      D_right = D_left == false;
      lbls_left = tabulate(lbls(D_left));
      lbls_right = tabulate(lbls(D_right));

      n_left = length(lbls_left);
      n_right = length(lbls_right);
      n_total = length(lbls);

      % Entropy is 0 if all belong to same class
      if isempty(lbls_left)
        lbls_left = [0, 0, 0];
      end
      if isempty(lbls_right)
        lbls_right = [0, 0, 0];
      end

      % Distributions of classes (proportion of points in each class)
      dist_left = nonzeros(lbls_left(:,2)) / n_left;
      dist_right = nonzeros(lbls_right(:,2)) / n_right;

      entropy_left = -sum(dist_left .* log2(dist_left));
      entropy_right = -sum(dist_right .* log2(dist_right));

      % Weighted avg
      entropy_curr = (n_left / n_total) * entropy_left + (n_right / n_total) * entropy_right;
      entropies(i) = entropy_curr;
    end

    [decision_entropy, decision_i] = min(entropies);
    decision_val = min_val + (max_val - min_val) / n_buckets * decision_i;

    decision_options(1,col_idx) = decision_entropy;
    decision_options(2,col_idx) = decision_val;
  end

  [~, feature_idx] = min(decision_options(1,:));
  Out.feature_idx = feature_idx;
  Out.decision_value = decision_options(2,feature_idx);
end
