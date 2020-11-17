function y = quantization(x, Nbit, qf)
% quantize input signal based on number of bits
% input:
%   x ... input signal (e.g. double precision)
%   Nbit ... number of bits used for quantization (e.g. Nbits=2)
%   qf ... quantization factor (percentage of sigma in quantization)
% output:
%   y ... quantized signal

% one bit
if Nbit == 1
    y = quant1(x);
end

% two bit
if Nbit == 2
    y = quant2(x, qf);
end

% three bit
% ...


end