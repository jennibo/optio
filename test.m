xpoint = [1;3;5;6;7];
ypoint = [0.6; 1.2; 1.3; 1.9; 2.3];

pf1 = polyfit(xpoint, ypoint, 4);
hold on;
pf = graf(5);
pf2 = graf(5);
x1 = linspace(0, 10);

P = polyval(pf, x1);



xStart = 0;
yStart = 2;

[~, dir] = generateRays(xStart, yStart, 0, -pi , 3);

point = intsec(pf, dir, xStart, yStart)
point(1,1)
point(2,1)
hold on;
line([point(1,1);xStart],[point(2,1),yStart]);
axis([-1 1 -2 2])



