function [ coordinates ] = coordinates( rayStart, rayDir, f )
%UNTITLED4 Summary of this function goes here

% Coordinates är en 2 x n matris där varje kolonn i matrisen beskriver en
% punkt. X-värdet i första raden. Y-värdet i andra.

coordinates = zeros(size(rayStart));

for j = 1:size(rayStart,2)
    r = f(1);
    for k = 2:length(f)
        r = conv(r,[rayDir(1,j),rayStart(1,j)]);
        r(end) = r(end) + f(k);
    end
    r(end) = r(end) - rayStart(2,j);
    r(end-1) = r(end-1) - rayDir(2,j);
    %r = r - [zeros(1,length(r)-2),rayDir(2,j),rayStart(2,j)];
    
    % Hittar lägsta positiva värdet för t
    allRoots = roots(r);
    allRoots(or(allRoots<0, abs(imag(allRoots))>1e-6)) = inf;
    t = real(min(allRoots));

    % Sätter in de nya X-koordinaterna i första raden på resultatmatrisen.
    coordinates(1, j) = rayStart(1, j) + t*rayDir(1, j);
    coordinates(2, j) = rayStart(2, j) + t*rayDir(2, j);
    %coordinates(2, j) = polyval(f, coordinates(1, j));
    
    fel = polyval(f, coordinates(1, j)) - coordinates(2, j)
end
end
