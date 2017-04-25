function [ coordinates ] = coordinates( rayStart, rayDir, f )
%UNTITLED4 Summary of this function goes here

% Coordinates �r en 2 x n matris d�r varje kolonn i matrisen beskriver en
% punkt. X-v�rdet i f�rsta raden. Y-v�rdet i andra.

% Skapar en tom vektor d�r funktionerna ska s�ttas in.
%funcs = zeros(length(rayStart));
coordinates = zeros(size(rayStart));

%for k = 1:length(rayStart)
%    funcs(k) = @(t) rayStart(k, :) + t * rayDir(k, :);
%end

for j = 1:length(rayStart)
    if rayDir(2,j)<-0.99999
        coordinates(1, j) = rayStart(1, j);
        coordinates(2, j) = polyval(f, coordinates(1, j));
    else
        r = f(1);
        for k = 2:length(f)
            r = conv(r,[rayDir(1,j),rayStart(1,j)]);
            r(end) = r(end) + f(k);
        end
        r = r - [zeros(1,length(r)-2),rayDir(2,j),rayStart(2,j)];
        % Hittar l�gsta positiva v�rdet f�r t
        allRoots = roots(r);
        allRoots(or(allRoots<0, abs(imag(allRoots))>1e-6)) = inf;
        t = min(allRoots);
        t = real(t);

        % S�tter in de nya X-koordinaterna i f�rsta raden p� resultatmatrisen.
        coordinates(1, j) = rayStart(1, j) + t*rayDir(1, j);
        coordinates(2, j) = polyval(f, coordinates(1, j));
    end
end
end
