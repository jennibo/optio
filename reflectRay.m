function rayDir = reflectRay(rayDir, n, c)
%reflectRay Reflects the direction rayDir at the surface specified by the
%normal n. c is the dot product of rayDir and n.

    rayDir = rayDir - 2*c.*n;

end