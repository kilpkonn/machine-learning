% Distance from vetor a to vector b with respect to covariance of data
function dist = mahalanobis_dist(a, b, data)
    C = cov(data);
    dist = sqrt((a - b).' / C * (a - b));  % NOTE: a and b might have to be col vectors
end