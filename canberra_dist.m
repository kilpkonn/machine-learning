% Distance from vector a to vector b
function dist = canberra_dist(a, b)
    tmp = abs(a - b) / (abs(a) + abs(b));
    dist = sum(tmp);
end