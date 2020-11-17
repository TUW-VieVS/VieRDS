function b= frac_delay_fir(ntaps,u,r)
% frac_delay_fir.m 1/29/20 Neil Robertson
% Fractional delay FIR filter. Passband range is f= 0 to fs/2.
%
% ntaps = number of taps of FIR filter. ntaps can be odd or even.
% u = fractional delay in samples. u can be positive or negative.
% b = FIR coefficients
% r = decibels of relative sidelobe attenuation

if mod(u,1)== 0
 u= u+ eps; % eps= 2.2e-16 prevent divide by zero
end
N= ntaps-1;
n= -N/2:N/2;
sinc= sin(pi*(n-u))./(pi*(n-u)); % truncated impulse response
win= chebwin(ntaps,r); % window function
b= sinc.*win'; % apply window function