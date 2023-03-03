function [MPS, MPS_YN] = createMPSstruct(J, M)
% assign frequency channel matching multi-point source (MPS) input data to struct
%
% input:
%   J ... match vector
%   M ... data matrix
%
% output:
%   MPS ... output

% pre-allocate flag
MPS_YN = 1;

% struct
MPS = struct;

% create MPS struct
if ~isempty(find(J ~= 0, 1))  
    
    % number of matches
    N = sum(J);
    
    % index of matches
    K = find(J);
    
    % loop over matches
    for i = 1:N
        
        % assgin index
        MPS(i).index = M(K(i),1);

        % assign fa
        MPS(i).fa = M(K(i),2);
        
        % assign fb
        MPS(i).fb = M(K(i),3);
        
        % assign RA (h,m,s)
        MPS(i).RA_hms = [M(K(i),4),M(K(i),5),M(K(i),6)];
        
        % assign DE (deg,m,s)
        MPS(i).DE_dms = [M(K(i),7),M(K(i),8),M(K(i),9)];
        
        % assign Sf
        MPS(i).Sf = M(K(i),10);
       
        % assign RA (rad)
        MPS(i).RA_rad = M(K(i),11);
        
        % assign RA (rad)
        MPS(i).DE_rad = M(K(i),12);
        
    end
else
    % print warning 
    warning('Cannot find any point source in this channel. No source signal will be simulated for this channel for the station.')

    % set flag
    MPS_YN = 0;
end

