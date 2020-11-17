function [y] = phaseOffsetMethods(x,phi0,fim)
% applies an arbitrary constant phase offset to the input signal
% the output signal stays real valued if input is real as well
%
% input:
%   x ... input signal
%   phi0 ... phase offset (rad)
%   fim .. filter method (string)
%
% output:
%   y ... output signal

if strcmp(fim,'neil-robertson-blog-method')
    
    % 31-tap Hilbert transformer
%     b= 2/pi * [-1/15 0 -1/13 0 -1/11 0 -1/9 0 -1/7 0 -1/5 0 -1/3 0 -1 0 1 0 ...
%         1/3 0 1/5 0 1/7 0 1/9 0 1/11 0 1/13 0 1/15];
%     b1= b.*hamming(31)';                          % window the coefficients
   
%     N = 200;           % Order
%     F = [0.01 0.99];  % Frequency Vector
%     A = [1 1];        % Amplitude Vector
%     W = 1;            % Weight Vector
%     
%     b1  = firls(N, F, A, W, 'hilbert');    % least-squares filter design
%     b2 = [zeros(1,(length(b1)-1)/2), 1]; % delay
%     
%     
%     I= filter(b2,1,x);                    % I= center tap of HT
%     Q= filter(b1,1,x);                    % Q= output of HT
%     y= I*cos(phi0) - Q*sin(phi0);         % phase shifter output
%     [y] = integerDelay(y,(length(b1)-1)/2);
%     
    y = x.*cos(phi0)+imag(hilbert(x)).*sin(phi0);
    
end

end

