function [ p ] = graf( klick )
% graf Lets the user draw one side of a lens with multiple clicks.
%   Accepts a number of clicks as input and constructs a polynomial to fit
%   the points where the user clicked with their mouse.
plot(0,0);

X = (1:klick + 2);
Y = (1:klick + 2);
X(1) = -0.9;
X(end) = 0.9;
Y(1) = 0;
Y(end) = 0;
plot([-0.9 0.9], [0 0],'o', 'color', 'black')

for k=1:klick
[X(k + 1), Y(k + 1)] = ginput(1);
plot(X(k + 1), Y(k + 1),'o', 'color', 'black');
end
p = polyfit(X,Y,klick + 1);
x = linspace(-0.9,0.9);
y = polyval(p,x);
hold on;
plot(x,y);
axis( [-1 1 -1 1]);
end
