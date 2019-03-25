function dist = point2line(point,vertex1,vertex2)
% dist = point2line(point,vertex1,vertex2) 
% The function claculates the shortest distance from a point to a line.
% output: 
%    dist (distance)
% input: 
%    point (a point not on a line)
%    vertex1, vertex2: two different points on a line

a = vertex1 - vertex2;
b = point - vertex2;
dist = norm(cross(a,b))/norm(a);
if point(2)>point(1)
    dist = -dist;
end
end