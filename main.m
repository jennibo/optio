%% Skapa polynomen.
figure;
hold on;
axis equal;
camroll(90);
axis([-1,1,-1,1]);
pf1 = graf(5);
pf2 = graf(5);
clf

hold on;
axis equal;
camroll(90);
axis([-1,1,-1,1]);
x1 = linspace(-0.9, 0.9);

plot(x1,polyval(pf1, x1), 'color', 'black');
plot(x1,polyval(pf2, x1), 'color', 'black');

xStart = 0;
yStart = 2;

n1 = 1;
n2 = 2;

%% Beräkna brytningarna.

% Create the rays.
[rayStart, rayDir] = generateRays(xStart, yStart, -2*pi/5, 2*pi/5 - pi, 10);

% In the beginning, all rays are outside.
inside = zeros(size(rayStart(1, :)));
refract = inside;

% As long as there still are rays that still intersects with the lens...
while ~isempty(rayStart)
    % ...find the intersection point with both surfaces...
    point = coordinates(rayStart, rayDir, pf1);
    point2 = coordinates(rayStart, rayDir, pf2);
    % ...choose the closest of the two...
    intersectedUpper = dot(rayStart - point, rayStart - point) < dot(rayStart - point2, rayStart - point2);
    point(:, not(intersectedUpper)) = point2(:, not(intersectedUpper));
    % ...find all the rays that intersects outside the lens...
    pointsToRemove = abs(point(1,:))>0.9;
    % ...draw these...
    line([rayStart(1, pointsToRemove); 4*rayDir(1, pointsToRemove)],[rayStart(2, pointsToRemove); 4*rayDir(2, pointsToRemove)], 'color', 'red');
    % ...and remove them from further calculations...
    point(:,pointsToRemove) = [];
    rayStart(:,pointsToRemove) = [];
    rayDir(:,pointsToRemove) = [];
    intersectedUpper(:,pointsToRemove) = [];
    inside(:,pointsToRemove) = [];
    refract(:,pointsToRemove) = [];
    % ...draw the remaining lines to their new intersection...
    line([rayStart(1, :); point(1, :)],[rayStart(2, :); point(2, :)], 'color', 'red');
    % ...calculate the new direction for those that intersected the
    % rightmost surface...
    [rayStart(:, not(intersectedUpper)), rayDir(:, not(intersectedUpper)), refract(:, not(intersectedUpper))] = refractRay(point(:, not(intersectedUpper)), rayDir(:, not(intersectedUpper)), pf2, n1, n2, inside(:, not(intersectedUpper)));
    % ...and those that intersected the leftmost surface...
    [rayStart(:, intersectedUpper), rayDir(:, intersectedUpper), refract(:, intersectedUpper)] = refractRay(point(:, intersectedUpper), rayDir(:, intersectedUpper), pf1, n1, n2, inside(:, intersectedUpper));
    % ...and toggle the inside flag for the rays that was refracted.
    inside = xor(inside, refract);
end