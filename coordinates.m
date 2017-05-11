function [ coordinates ] = coordinates( rayStart, rayDir, f )
% coordinates Takes a set of lines and a polynomial function
% and calculates the intersection points between the lines and the polynomial. 

% Coordinates is a 2 x n matrix where every column in the matrix represents
% a point. X-value in the first row, and Y-value in the second.

coordinates = zeros(size(rayStart));

% Works through all the rays.
for j = 1:size(rayStart,2)
    % Constructs a polynomial of t where the smallest positive root
    % represents the length the rays has to travel before they hit the
    % surface of the lens.
    r = f(1);
    for k = 2:length(f)
        r = conv(r,[rayDir(1,j),rayStart(1,j)]);
        r(end) = r(end) + f(k);
    end
    % Subtracts the polynomial with the line representing the current ray.
    r(end) = r(end) - rayStart(2,j);
    r(end-1) = r(end-1) - rayDir(2,j);
    
    % Finds the smallest positive value for t.
    allRoots = roots(r);
    allRoots(or(allRoots<=1.0e-3, abs(imag(allRoots))>1e-6)) = inf;
    t = real(min(allRoots));
    
    % Inserts the new X-coordinates in the first row of "coordinates".
    coordinates(1, j) = rayStart(1, j) + t*rayDir(1, j);
    % Inserts the new Y-coordinates in the first row of "coordinates".
    coordinates(2, j) = rayStart(2, j) + t*rayDir(2, j);
end
end
