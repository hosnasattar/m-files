function out = StrFilter(target,exp,casesensitive)
%% Filter input according to certain patterns.
%
% out = StrFilter(target,exp)
%
% Input parameters (required):
%
% target : string or cellstring containing the data.
% exp    : regular expression pattern to be matched against.
%
% % Input parameters (optional):
%
% casesensitive : whether to be case sensitive (default = true).
%
% Output parameters:
%
% out : cellstr or string with found matches.
%
% See also strfind, regexp

% Copyright 2012 Laurent Hoeltgen <laurent.hoeltgen@gmail.com>
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

% Last revision: 30.08.2012 11:22

%% Check input parameters

narginchk(2, 3);
nargoutchk(0, 1);

if nargin == 2
    casessensitive = true;
end

if iscellstr(target)
    if casesensitive
        out = target(cellfun(@(s) ~isempty(regexp(s,exp, 'once')),target));
    else
        out = target(cellfun(@(s) ~isempty(regexpi(s,exp, 'once')),target));
    end
elseif ischar(target)
    if casesensitive
        if ~isempty(regexp(target,exp, 'once'))
            out = target;
        else
            out = [];
        end
    else
        if ~isempty(regexpi(target,exp, 'once'))
            out = target;
        else
            out = [];
        end
    end
else
    error('First argument must be string or cell string');
end
end
