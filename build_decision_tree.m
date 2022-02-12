% D - Data matrix
% lbls - Labels for data
% p - target accuracy on trainig data
% criteria_fn - Decision criteria, should return feature_idx and decision_value to split on
function Node = build_decision_tree(D, lbls, p, criteria_fn)
  classes_tbl = tabulate(lbls);
  curr_accuracy = max(classes_tbl(:,2)) / length(lbls);
  if curr_accuracy >= p
    [~, max_idx] = max(classes_tbl(:,2));
    Node.class = classes_tbl(max_idx,1);
    return;
  end

  split_on = criteria_fn(D, lbls);
  D_left_lookup = D(:,split_on.feature_idx) <= split_on.decision_value;
  D_right_lookup = D_left_lookup == false;
  D_left = D(D_left_lookup,:);
  D_right = D(D_right_lookup, :);
  lbls_left = lbls(D_left_lookup);
  lbls_right = lbls(D_right_lookup);

  Node.split_feature = split_on.feature_idx;
  Node.decision_value = split_on.decision_value;

  if ~isempty(lbls_left) && ~isempty(lbls_right)
    left_child = build_decision_tree(D_left, lbls_left, p, criteria_fn);
    right_child = build_decision_tree(D_right, lbls_right, p, criteria_fn);

    Node.left = left_child;
    Node.right = right_child;
  end
end
