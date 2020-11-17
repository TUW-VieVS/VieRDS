function [ power ]  = fluxdensity2power( flux_density,effective_antenna_area,bandwidth )
% This function calculates the power which is collected by an antenna with
% an effective area under a certain bandwdith load from a source with a
% certain strength.
%
% P ... power in Watts [W]
% S ... spectral power flux density (spectral flux density or short flux
% density) in Jy*10^-26 = W/(m^2*Hz)
% BW ... Bandwidth in Hz
% A ... effective area of antenna in m^2
%
% P = S * A * BW
%
% Input: 
% fluxdensity in Watts/(m^2*Hz)
% effective antenna area in m^2
% bandwidth in Hz+
%
% Output:
% power in Watts 

power = flux_density * effective_antenna_area * bandwidth;

end

