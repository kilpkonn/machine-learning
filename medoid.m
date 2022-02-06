
function res = medoid(data, s)
  res = data(1,:);
  best_dist = Inf;

  rows = size(data, 1);

  for i = 1:rows
    a = data(i,:);
    dist = 0;
    for j = 1:rows
      b = data(j,:);
      dist = dist + s(a, b);
    end
    
    if dist < best_dist
      best_dist = dist;
      res = a;
    end
    dist = 0;
  end
end
