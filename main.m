f = @(x) 2.*x;

g = @(x) -4.*x + 2;

x1 = linspace(0, 1);

plot(x1, f(x1));
hold on;
plot(x1, g(x1));

fzero(@(x)f(x)-g(x), 0)