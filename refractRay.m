function [ rayStart, rayDir2, refracted ] = refractRay(hit, rayDir, p, n1, n2, inside)
%refractRay generates new refracted lines at a given position hit, original
%lines rayDir, polynomial function, p and refraction indexes, n1 and n2.

%calculating the derivative of the function and using it to calculate the normal
n = [-polyval(polyder(p), hit(1, :)); ones(size(hit(1, :)))]; 
n = normc(n); 

%constants to the function below
r = (1 - inside)*n1/n2 + inside*n2/n1;
c = -dot(n, rayDir);
n(:, c<0) = -n(:, c<0);
c = abs(c);

%the function that calculates the new refracted rays can be found at https://en.wikipedia.org/wiki/Snell%27s_law

%refracted is a boolean matrix, with true for the refracted rays and false
%for the reflected rays.
refracted = 1 - r.^2.*(1 - c.^2) >= 0;

%make the constants the same size as rayDir
r = repmat(r, 2, 1);
c = repmat(c, 2, 1);

%there are equal rays before and after the encounter with the surface
rayDir2 = zeros(size(rayDir));

%the direction of the refracted rays is calculated
rayDir2(:, refracted) = r(:, refracted).*rayDir(:, refracted) + (r(:, refracted).*c(:, refracted) - sqrt(1-r(:, refracted).^2.*(1-c(:, refracted).^2))).*n(:, refracted);

%the direction of the reflected rays is calculated
rayDir2(:, not(refracted)) = reflectRay(rayDir(:, not(refracted)), n(:, not(refracted)), -c(:, not(refracted)));
rayDir2 = normc(rayDir2);

%the orgin of the new rays
rayStart = hit; 
end
