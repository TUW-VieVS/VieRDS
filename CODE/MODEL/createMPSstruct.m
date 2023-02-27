function [MPS] = createMPSstruct(J, M)
% assign frequency channel matching multi-point source (MPS) input data to struct
%
% input:
%   J ... match vector
%   M ... data matrix
%
% output:
%   MPS ... output

% struct
MPS = struct;

% create MPS struct
if ~isempty(find(J ~= 0, 1))  
    
    % number of matches
    N = sum(J);
    
    %
    K = find(J);
    
    for i = 1:N
        
        % assign fa
        MPS(i).fa = M(K(i),1);
        
        % assign fb
        MPS(i).fb = M(K(i),2);
        
        % assign RA (h,m,s)
        MPS(i).RA_hms = [M(K(i),3),M(K(i),4),M(K(i),5)];
        
        % assign DE (deg,m,s)
        MPS(i).DE_dms = [M(K(i),6),M(K(i),7),M(K(i),8)];
        
        % assign Sf
        MPS(i).Sf = M(K(i),9);
       
        % assign RA (rad)
        MPS(i).RA_rad = M(K(i),10);
        
        % assign RA (rad)
        MPS(i).DE_rad = M(K(i),11);
        
    end
end

