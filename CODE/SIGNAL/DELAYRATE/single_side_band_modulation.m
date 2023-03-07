function [y] = single_side_band_modulation(x,f0,dtau,Tx)
% shifts the input signal by a delay per sample
%
% input:
%   x ... signal
%   f0 ... reference frequency
%   dtau ... delta delay (sec)
%
% output:
%   y ... delayed signal

% frequency parameters (Hz)
fs = 1/Tx;
fbw = fs/2;
fa = f0-fbw/2;

% normalized angle [0,1]
a = f0.*dtau;

% radiant angle [0,2pi]
phi = -2*pi*a;

% apply linear frequency shift (periodicity with phi 2*pi), working area only between 0 and 1 for a
y = x.*cos(phi)+imag(hilbert(x)).*sin(phi);

% round normalized angle to integer values
m = floor(a);

% wavelength of sky center frequency f0 (sec)
lamd = 1/f0;

% delay based on integer normalized angles
tau0 = m*lamd;

% fractional delay
dn = tau0/Tx;
% 
% figure; hold on;
% plot(dtau,'.-');
% plot(tau0,'.-');



% unique fractional delay values
dnu = unique(dn,'stable');

% number of unique fraction delay values
Ndnu = length(dnu);

% fractional delay application settings
ntaps = 51;
Nf = (ntaps-1)/2;
r = 30;

% pre-allocate output signal
% In=cell(Ndnu,1);
Out=cell(Ndnu,1);

% get blocks
for i=1:Ndnu
    
    % current fractional sample delay
    dni = dnu(i);
    
    % indicies for the same fractional sample of interest
    ind = dni==dn;
    
    % split up signal into blocks and store them in seperate cells
    In{i} = y(ind);
end

% blockwise fractional delay correction
parfor i=1:Ndnu
    dni = dnu(i);
    
    % check if the length of the signal block is larger than the signal
    % length of the convolution (filter) function. 
    if length(In{i}) > Nf
        
        if abs(dni)>Nf
            warning('fraction sample delay is larger than filter length')
            fprintf('fractional sample delay (dn) of current block is larger than working range of function (Nf). dn: %f Nf: %f \n',dni,Nf)
        end
        fprintf('%f ', dni);
%         Out{i} = fractional_delay_application_fir(In{i},-dni,ntaps,r);
        n0 = round(dni);
        dn0 = dni-n0;
        phi0 = -2*pi*fa*dni*Tx;
        [Out{i}] = delay3step(In{i},n0,dn0,phi0,ntaps,r,0)
%         Out{i} = In{i};
        
%         % apply constant phase offset to to all spectral components. Since the
%         % integer and fractional delay application only applies a phase slope
%         % which means that the phase is zero at the lower frequency limit.
%         % (like a line without a y-shift at zero). To account for this
%         % cirumstance, and it is required to enable multiband delays, a
%         % constant phase offset has to be applied to all spectral components.
%         % This is realized with a complex phase rotation of a constant factor
%         
%         % phase offset
%         [phi0,~] = skyFreqPhaseOffset(fa,tau0,Tx)
%                 
%         if phi0 ~= 0
%             
%             % time domain approach with hilbert transform
%             fim = 'neil-robertson-blog-method';
%             [Out{i}] = phaseOffsetMethods(Out{i},-phi0,fim);
%             
%         end
    else
        Out{i} = In{i};
    end
end

fprintf('\n');

z = [Out{:}];

% correct for integer filter delay
y = integerDelay(z,(ntaps-1)/2);


end

