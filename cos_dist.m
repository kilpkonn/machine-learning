% Distance from vector a to vector b (both have to be positive)
function dist = cos_dist(a, b)
    dist = 1 - dot(a, b) / (sqrt(dot(a, a)) * sqrt(dot(b, b)));
end
