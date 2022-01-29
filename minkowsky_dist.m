% Distance from vector a to vector b with hyper param p
function dist = minkowsky_dist(a, b, p)
    tmp = abs(a - b).^p;
    dist = sum(tmp)^(1/p);
end