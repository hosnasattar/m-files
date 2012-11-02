function [ Err ] = ErrorApproxInfLoc(f, x)
% [ Err ] = ErrorInterpInfLoc( f, x )
% ErrorApproxInfLoc computes the local L-infinity approximation error between
% two consecutive knots for the function f and its piecewise linear spline
% interpolation with knots x.
%
% Usage: [ Err ] = ErrorApproxInfLoc( f, x )
% f   : a handle to the considered function.
% x   : an array with the support points for the linear splines.
% Err : an array with the conmputed errors for the approximation between x(i)
%       and x(i+1).
%
% See also ErrorApprox, ErrorApproxLoc, ErrorInterp, ErrorApproxInterval

% Copyright 2011,2012 Laurent Hoeltgen <laurent.hoeltgen@gmail.com>
%
% This program is free software; you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation; either version 3 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License along with
% this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
% Street, Fifth Floor, Boston, MA 02110-1301, USA.

% Last revision: 02.11.2012 11:24

%% Check number of input and output arguments.

narginchk(2,2);
nargoutchk(0,1);

Err = zeros(1,length(x)-1);
for i = 1:(length(x)-1)
    t = linspace(x(i),x(i+1), 1024);    
    Err(i) = max(abs(FreeKnot.ApproxLinSpline(t,x,f)-f(t)));
end
end
