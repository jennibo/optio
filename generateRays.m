function [rayStart, rayDir] = generateRays( x, y, angle1, angle2, N )
% generateRays Generates the original rays from a point source.
%   Generates N lightrays originating from the point (x, y) going in the
%   directions between angle1 and angle2.

    % Creates all the angles the rays will have.
    angles = linspace(angle1, angle2, N);
    
    % Repeat the position (x, y) for all rays.
    rayStart = repmat([x;y],1,N);
    
    % Creates all the directions for the rays.
    rayDir = [cos(angles);sin(angles)];
end