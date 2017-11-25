function y = beta_lpdf(x,a,b)
%BETA_LPDF    Beta log-probability density function (lpdf).
%
%   Y = BETA_LPDF(X,A,B) Returns the log of the Beta pdf with
%   parameters A and B, at the values in X.
%
%   The size of Y is the common size of the input arguments. A scalar input  
%   functions as a constant matrix of the same size as the other inputs.     
%
%   Default value for A and B is 1.

% Copyright (c) 2005 Aki Vehtari

% This software is distributed under the GNU General Public 
% License (version 3 or later); please refer to the file 
% License.txt, included with the software, for details.

if nargin < 3, 
  a = 1;
end

if nargin < 2;
  b = 1;
end

if nargin < 1, 
  error('Requires at least one input argument.');
end

y= (a-1).*log(x) +(b-1).*log(1-x) -betaln(a,b);
