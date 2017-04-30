function [ coordinates ] = coordinates( rayStart, rayDir, f )
% Takes a set of lines and a polynomial function
% and calculates the intersection points between the lines and the polynomial. 

% Coordinates �r en 2 x n matris d�r varje kolonn i matrisen beskriver en
% punkt. X-v�rdet i f�rsta raden. Y-v�rdet i andra.

coordinates = zeros(size(rayStart));

for j = 1:size(rayStart,2)
    r = f(1);
    
    % Konstruerar ett polynom i t d�r den minsta positiva roten motsvarar l�ngden str�larna
    % g�r innan de tr�ffar ytan.
    for k = 2:length(f)
        r = conv(r,[rayDir(1,j),rayStart(1,j)]);
        r(end) = r(end) + f(k);
    end
    r(end) = r(end) - rayStart(2,j);
    r(end-1) = r(end-1) - rayDir(2,j);
    %r = r - [zeros(1,length(r)-2),rayDir(2,j),rayStart(2,j)];
    
    % Hittar l�gsta positiva v�rdet f�r t
    allRoots = roots(r);
    allRoots(or(allRoots<=1.0e-3, abs(imag(allRoots))>1e-6)) = inf;
    t = real(min(allRoots));

    % S�tter in de nya X-koordinaterna i f�rsta raden p� resultatmatrisen.
    coordinates(1, j) = rayStart(1, j) + t*rayDir(1, j);
    % S�tter in de nya Y-koordinaterna i andra raden p� resultatmatrisen.
    coordinates(2, j) = rayStart(2, j) + t*rayDir(2, j);
    %coordinates(2, j) = polyval(f, coordinates(1, j));
    
    fel = polyval(f, coordinates(1, j)) - coordinates(2, j)
end
end
