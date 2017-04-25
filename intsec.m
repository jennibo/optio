function [ point ] = intsec( pf, dir, startX, startY)
point = zeros(size(dir));

for i=1:size(dir,2)
%gives the position of the intersection
g = @(x) (dir(2,i)./dir(1,i)).* x + startY - (dir(2,i).*startX)./dir(1,i);
xpoint = fzero(@(x)g(x)-polyval(pf,x), 0);
ypoint = g(xpoint);

point(:,i) = [xpoint; ypoint];
end
end

