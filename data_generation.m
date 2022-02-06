clear 
clc

labels_count = 3;
labels_names = 1:labels_count;
labels_points = [200, 300, 500];


eig_vecs = cell(1, labels_count);
eig_vecs{1} = [[1, 0]; [0, 1]];
eig_vecs{2} = [[0.7, 0.7]; [0.7, -0.7]];
eig_vecs{3} = [[0.4, 0.91]; [-0.91, 0.4]];

eig_vals = [[1, 2];
            [0.5, 2];
            [3, 1]];

means = [[-4, 4];
         [3, 3];
         [0, -2]];

data_matrix = zeros(sum(labels_points), 2);

rng(1);

for i = 1:labels_count
  count = labels_points(i);
  eig_vec = eig_vecs{i};
  eig_val = eig_vals(i,:);
  m = means(i,:);
  C = eig_vec * diag(eig_val) / eig_vec;
  xx = mvnrnd(m, C, count);
 
  fh(1) = figure(1);
  switch i
      case 1
          cl = 'blue';
      case 2
          cl = 'red';
      case 3 
          cl = 'green';
  end

  scatter(xx(:,1), xx(:,2), cl);
  hold on
  xlim([-10,10]);
  ylim([-10,10]);
  
  data_matrix((sum(labels_points(1:(i-1))) + 1):sum(labels_points(1:i)),:) = xx;
end

save('./data/clusters1.mat', 'data_matrix');
