function [y] = nufft_wrapper(x,dr,fs,fa)
% delay rate application wiht non-uniform fft
%
% input:
%   x ... input signal
%   dr ... delay rate (s/s)
%   fs ... sampling rate (Hz)
%   fa ... lower sky frequency limit (Hz)
%
% output:
%   y ... non-uniformed sampled x with delay rate dr

% sampling interval (sec)
Tx = 1/fs;

% upper sky frequency limit (Hz)
fb = fa+fs/2;

% ref. frequency (Hz)
fr = (fa+fb)/2;

% number of samples
Ns = length(x);

% number of nufft blocks
Nb = length(dr);

% number of samples per nufft block
Nbs = ceil(Ns/Nb);

% number of samples difference for last block due to "ceil"
dNs = Nbs*Nb-Ns;

% pre-allocate ouput vector
y = zeros(1,Ns);

% pre-allocate array of delays
d = zeros(1,Nb);

% pre-allocate 
IND = cell(1,Nb);
NI = zeros(1,Nb);
TI = zeros(1,Nb);
FX = zeros(1,Nb);
D = zeros(1,Nb);
DN = zeros(1,Nb);
PHI = zeros(1,Nb);
X = cell(1,Nb);
Y = cell(1,Nb);

% prepare data
for ib = 1:Nb
    
    % index
    if ib~=Nb
        ind = Nbs*(ib-1)+1:Nbs*ib;
    else
        ind = Nbs*(ib-1)+1:Nbs*ib-dNs;
    end
    
    % index 
    IND{ib} = ind;
    
    % signal block
    X{ib} = x(IND{ib});
    
    % number of samples of block
    NI(ib) = length(ind);
    
    % signal length in sec
    TI(ib) = NI(ib)/fs;
    
    % sampling interval in the frequency domain (Hz)
    FX(ib) = 1/TI(ib);    
    
    % delay
    d(ib) = dr(ib)*TI(ib);
    
    % cummulativ delay
    D(ib) = sum(d(1:ib));
    
    % fractional delay (sample)
    DN(ib) = D(ib)/Tx;
    
    % phase delay
    PHI(ib) = 2*pi*D(ib)*fr;    
    
end

% for each block
parfor ib = 1:Nb
    
    % signal block
    xi=X{ib};
    
    % current delay rate (sec/sec)
    dri = dr(ib);   
    
    % uniform frequency vector
    f = (0:NI(ib)-1)*FX(ib);
    
    % doppler shift at sky freqeuncies
    df = (fa+f)*dri;
    
    % non-uniform frequency vector
    fnu = f+df;
    
    % print
    fprintf('dr: %f ns/s block: %d/%d, f+df(1): %f MHz, f+df(end): %f MHz\n',dri*1e9,ib,Nb,fnu(1)*1e-6,fnu(end)*1e-6)
    
    % normalized non-uniform frequency vector
    fnu0 = fnu/fs;
    
    % phase offset at block start
    if ib~=1
        if abs(PHI(ib))>2*pi
            warning('angle of phase shift exceeds full circle. High delay rates?')
        end        
        % const. phase shift for each sample
        xi = xi.*exp(-1i*PHI(ib-1));               
    end
    
    % symmetric non-uniform inverse fft
    Y{ib} = ifft(nufft(xi,[],fnu0),'symmetric');
    
end

y = [Y{:}];

fprintf('\n');

end

