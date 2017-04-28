function [ p ] = graf( klick )
%GRAF Summary of this function goes here
%   Detailed explanation goes hereplot(0,0)
plot(0,0);

X = (1:klick + 2);
Y = (1:klick + 2);
X(1) = -0.9;
X(end) = 0.9;
Y(1) = 0;
Y(end) = 0;
for k=1:klick
[X(k + 1), Y(k + 1)] = ginput(1);
plot(X(k + 1), Y(k + 1),'o');
end
p = polyfit(X,Y,klick + 1);
x = linspace(-0.9,0.9);
y = polyval(p,x);
hold on;
plot(x,y);
axis( [-1 1 -1 1]);


end

