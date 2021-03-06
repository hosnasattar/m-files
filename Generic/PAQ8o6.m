function varargout = PAQ8o6(name, varargin)
%% Compresses a file with PAQ8o6
%
% [status result] = PAQ806(name, varargin)
%
% Input parameters (required):
%
% name : Name of the file to be compressed.
%
% Input parameters (parameters):
%
% Parameters are either struct with the following fields and corresponding
% values or option/value pairs, where the option is specified as a string.
%
% level  : compression level. Integer between 0 and 8. (default = 3) (scalar)
% delete : whether to delete original file after compression. (boolean)
%          (default = false)
% echo   : whether to echo the output. (boolean) (default = false)
%
% Input parameters (optional):
%
% The number of optional parameters is always at most one. If a function takes
% an optional parameter, it does not take any other parameters.
%
% -
%
% Output parameters:
%
% status : Return value from the paq8o6 binary.
% result : Return value from the paq8o6 binary.
%
% Output parameters (optional):
%
% -
%
% Description:
%
% Compresses a file using the paq8o6 compression scheme. The binary must be
% installed somewhere, where the system command can find it. The program is
% available from: http://cs.fit.edu/~mmahoney/compression/ and is licensed under
% the GPL.
%
% Example:
%
% -
%
% See also UnPAQ8o6, zip, gzip, tar

% Copyright 2013 Laurent Hoeltgen <laurent.hoeltgen@gmail.com>
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

% Last revision on: 05.02.2013 16:11

%% Notes

%% Parse input and output.

narginchk(1,7);
nargoutchk(0,2);

parser = inputParser;
parser.FunctionName = mfilename;
parser.CaseSensitive = false;
parser.KeepUnmatched = true;
parser.StructExpand = true;

parser.addRequired('name', @(x) validateattributes( x, {'char'}, ...
    {'row'}, mfilename, 'name', 1) );

parser.addParamValue('level', 3, @(x) validateattributes( x, {'numeric'}, ...
    {'scalar', 'integer', '>=', 0, '<=', 8 }, mfilename));

parser.addParamValue('delete', false, @(x) validateattributes( x, ...
    {'logical'}, {'scalar'}, mfilename));

parser.addParamValue('echo', false, @(x) validateattributes( x, ...
    {'logical'}, {'scalar'}, mfilename));

parser.parse(name, varargin{:});
opts = parser.Results;

% Do not overwrite any existing file.
MExc = ExceptionMessage('Input', 'message', ...
    'Target file already exists. Aborting.');
assert(exist([name '.paq8o6'], 'file')==0, MExc.id, MExc.message);

%% Run code.

% Check whether there is a pbmtojbg binary.
[status paq8o6] = system('which paq8o6');

% The last character is a new line feed.
paq8o6 = paq8o6(1:(end-1));

if status == 0
    if opts.echo
        [varargout{1:nargout}] = system([paq8o6 ' -' num2str(opts.level) ...
            ' ' name], '-echo');
    else
        [varargout{1:nargout}] = system([paq8o6 ' -' num2str(opts.level) ...
            ' ' name]);
    end
    if opts.delete
        delete(name);
    end
else
    MExc = ExceptionMessage('Internal', 'message', ...
        'Cannot find paq8o6 executable');
    error(MExc.id, MExc.message);
end

end
