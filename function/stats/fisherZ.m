function z = fisherZ(r)
% Fisher's z-transformation
%
% r: matrix (ex. results from Pearson's correlation values)
% z: Fisher's z-transformation value
%
% Author: Junyeop Lee
% Version: 1.0 (6. 15. 2016)

r = r(:);
% n = length(r);
z = 1/2*log((1+r)./(1-r));
% error = 1/(sqrt(n-3));
end