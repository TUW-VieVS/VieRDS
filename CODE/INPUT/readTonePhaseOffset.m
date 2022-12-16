function [P] = readTonePhaseOffset(P)
% reads tone phase offset file 
%
%    input:
%   P ... simulation struct
%
% output:
%   P ... updated station struct with phase offsets per tone

% number of simulations/channels
NSIM = length(P);

% pre-allocate TPO struct
TPO = struct;

for isim = 1:NSIM
    
    % assing station SIM struct to new variable
    p = P{isim,1};
    

    [ St, Nst ] = station_struct_label( p );


    for iSt = 1:Nst

        pj = p.(St{iSt});
        tpo = pj.phase_cal_tone_phase_offset_file;
        
        if isfield(TPO,St{iSt})
            if isfield(TPO.(St{iSt}),'m')
                tpo_found = 1;
            else
                tpo_found = 0;
            end
        else
            tpo_found = 0;                
        end

        if isempty(tpo)
            % no tone phase offset file defined
%             fprintf('no tone phase offset file specified\n')
        else
            if tpo_found == 0
                % tone phase offset file specified
                fprintf('tone phase offset file specified: %s\n',tpo)

                % read tpo file content to matrix
                m = dlmread(tpo);

                % number of channels and tones
                [Nch,~] = size(m);

                % check number of channels
                if Nch==NSIM

                else
                    fprintf('number of channels defined by center frequency: %d\n',NSIM)
                    fprintf('number of channels specified via tone phase offset file: %d\n',Nch)
                    error('number of channels specified in tone phase offset file does NOT match number of channels defined by center frequencies')
                end

                % assign tpo matrix to new struct
                TPO.(St{iSt}).m = m;
            end
        end

    end
    
end

[ St, Nst ] = station_struct_label( TPO );

% assign tone phase offsets to correct SIM STAT position
for iSt = 1:Nst
    M = TPO.(St{iSt}).m;
    
    % number of channels and tones
    [Nch,~] = size(M);
    
    % assing correct lines of tpo file to channel/SIM struct
    for iSim = 1:Nch
        P{iSim,1}.(St{iSt}).phase_cal_tone_phase_offset = M(iSim,:);
    end
    
end

end

