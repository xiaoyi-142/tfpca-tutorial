% PURPOSE: updates artifact detection info within reaction time info contained at BDF structure
%
% Format
%
% EEG = updatebdfstruct(EEG)
%
%
% *** This function is part of ERPLAB Toolbox ***
% Author: Javier Lopez-Calderon & Steven Luck
% Center for Mind and Brain
% University of California, Davis,
% Davis, CA
% 2009

%b8d3721ed219e65100184c6b95db209bb8d3721ed219e65100184c6b95db209b
%
% ERPLAB Toolbox
% Copyright � 2007 The Regents of the University of California
% Created by Javier Lopez-Calderon and Steven Luck
% Center for Mind and Brain, University of California, Davis,
% javlopez@ucdavis.edu, sjluck@ucdavis.edu
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

function EEG = updatebdfstruct(EEG)

%
% Tests RT info
%
if ~isfield(EEG.EVENTLIST.bdf, 'rt')
      return
else
      valid_rt = nnz(~cellfun(@isempty,{EEG.EVENTLIST.bdf.rt}));
      
      if valid_rt==0
            return
      end
end

nbin = EEG.EVENTLIST.nbin;

for i=1:nbin
      
      col = size(EEG.EVENTLIST.bdf(i).rtitem,2);
      
      for j=1:col
            indxitem = EEG.EVENTLIST.bdf(i).rtitem(:,j);
            flags = num2cell([EEG.EVENTLIST.eventinfo(indxitem).flag]);
            [EEG.EVENTLIST.bdf(i).rtflag(:,j)] = flags{:};
      end
end

