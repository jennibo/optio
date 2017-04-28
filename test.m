xpoint = [1;3;5;6;7];
ypoint = [0.6; 1.2; 1.3; 1.9; 2.3];

n1 = 1;
n2 = 2;
f = 2;
r = 2*f*(n2/n1 - 1);

pf1 = polyfit(xpoint, ypoint, 4);
figure;
hold on;
axis equal;
camroll(90);
axis([-1,1,-1,1]);
pf = graf(5);
pf2 = graf(5);
x1 = linspace(-0.9, 0.9);

% Någon potatis för tester.
%pf = [-0.448358984336114 0.0513151983795273 0.564538701769800 -0.0689153854661590 -0.567677443977241 0.0221535605707811 0.327701234384968];
%pf2 = [-0.352047674228521 -0.419902833090198 0.642347122647016 0.392165904087537 0.171511732318196 -0.0421561335204259 -0.373275882306766];

%syms x;
%pf = double(sym2poly(taylor(sqrt(r^2 - x^2) - sqrt(r^2 - 0.9^2))));
%pf2 = -pf;

P = polyval(pf, x1);

plot(x1,polyval(pf, x1));
plot(x1,polyval(pf2, x1));



xStart = 0;
yStart = 2;

[rayStart, rayDir] = generateRays(xStart, yStart, -2*pi/5, 2*pi/5 - pi, 10);

%point = intsec(pf, rayDir, xStart, yStart);
point = coordinates(rayStart, rayDir, pf);

pointsToRemove = repmat(abs(point(1,:))>0.9,2,1);
point(pointsToRemove) = [];
point = reshape(point,[2,numel(point)/2]);
rayStart(pointsToRemove) = [];
rayStart = reshape(rayStart,[2,numel(rayStart)/2]);
rayDir(pointsToRemove) = [];
rayDir = reshape(rayDir,[2,numel(rayDir)/2]);

[rayStart2, rayDir] = refractRay(point, rayDir, pf, n1, n2);

point2 = coordinates(rayStart2, rayDir, pf2);

pointsToRemove = isinf(point2);
point2(pointsToRemove) = [];
point2 = reshape(point2,[2,numel(point2)/2]);
point(pointsToRemove) = [];
point = reshape(point,[2,numel(point)/2]);
rayStart(pointsToRemove) = [];
rayStart = reshape(rayStart,[2,numel(rayStart)/2]);
rayDir(pointsToRemove) = [];
rayDir = reshape(rayDir,[2,numel(rayDir)/2]);

[rayStart2, rayDir] = refractRay(point2, rayDir, pf2, n2, n1);

line([rayStart(1,:);point(1,:);point2(1,:);point2(1,:)+2*rayDir(1,:)],[rayStart(2,:);point(2,:);point2(2,:);point2(2,:)+2*rayDir(2,:)]);

n = [-polyval(polyder(pf), point(1, :)); ones(size(point(1, :)))];
n = normc(n);
line([point(1,:)-0.1*n(1,:);point(1,:)+0.1*n(1,:)],[point(2,:)-0.1*n(2,:);point(2,:)+0.1*n(2,:)]);
n = [-polyval(polyder(pf2), point2(1, :)); ones(size(point2(1, :)))];
n = normc(n);
line([point2(1,:)-0.1*n(1,:);point2(1,:)+0.1*n(1,:)],[point2(2,:)-0.1*n(2,:);point2(2,:)+0.1*n(2,:)]);