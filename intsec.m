function [ point ] = intsec( pf, dir, startX, startY)
%gives the position of the intersection
g = @(x) (dir(2,1)./dir(1,1)).* x + startY - (dir(2,1).*startX)./dir(1,1);
xpoint = fzero(@(x)g(x)-polyval(pf,x), 0);
ypoint = g(xpoint);

point = [xpoint; ypoint];
end

