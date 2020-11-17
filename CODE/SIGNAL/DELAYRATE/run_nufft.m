function [y] = run_nufft(ib,Nb,x,ind,Fx,Ni,dri,fs,fa,phi)
% run nufft
%
% input:
%   x ... total signal
%   ind ... index
%   Fx
%   Ni
%   dri
%   fs
%   phi
%
% output:
%   y ... output signal

fprintf('dr: %f ns/s block: %d/%d\n',dri*1e9,ib,Nb)

% signal block
xi = x(ind);

% uniform frequency vector
f = (0:Ni-1)*Fx;

% doppler shift at sky freqeuncies
df = (fa+f)*dri;

% non-uniform frequency vector
fnu = f+df;

fprintf('f(1): %f MHz, f(end): %f MHz\n',fnu(1)*1e-6,fnu(end)*1e-6)

% normalized non-uniform frequency vector
fnu0 = fnu/fs;

% phase offset at block start
if ib~=1
    % const. phase shift for each sample
    xi = xi.*exp(-1i*phi);
end

% symmetric non-uniform inverse fft
y = ifft(nufft(xi,[],fnu0),'symmetric');


end

