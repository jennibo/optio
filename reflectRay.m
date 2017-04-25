function rayDir = reflectRay(rayDir, n)
%reflectRay Reflects the direction rayDir at the surface specified by the
%normal n

    rayDir = rayDir - 2*repmat(dot(n, rayDir), 2, 1).*n; % d2 = d1 - 2*(n.d1)*n

end