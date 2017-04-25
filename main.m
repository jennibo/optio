[rayStart, rayDir] = generateRays(0, 0, 0, -pi, 7);

f = @(x) 2.*x;

line([rayStart(1, :); rayDir(1, :)+rayStart(1, :)], [rayStart(2, :); rayDir(2, :)+rayStart(2, :)])