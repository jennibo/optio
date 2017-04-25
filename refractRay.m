function [ rayStart, rayDir2 ] = refractRay(hit, rayDir, p, n1, n2)
%refractRay generates new refracted lines at a given position hit, original
%lines rayDir, polynomial function, p and refraction indexes, n1 and n2.

%calculating the derivative of the function and using it to calculate the normal
n = [-polyval(polyder(p), hit(:, 1)); ones(size(hit(:, 1)))]; 
n = normc(n); 

%constants to the function below
r = n1/n2;
c = -repmat(dot(n, rayDir), 2, 1);

%function can be found at https://en.wikipedia.org/wiki/Snell%27s_law
rayDir2 = r*rayDir + (r*c - sqrt(1-r^2*(1-c.^2))).*n; 
rayDir2 = normc(rayDir2);

%the orgin of the new refracted rays
rayStart = hit; 
end
