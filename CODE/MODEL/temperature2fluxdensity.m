function [ flux_density ] = temperature2fluxdensity( temperature,effective_area )
% This function calculates the spectral power flux density (also known as
% spectral flux density or simple flux density) by knowing the temperature
% of an antenna. 
%
% The following physical
% concept is used:
%
% P ... power in Watts W
% k ... Boltzmann constant W*K^-1*Hz^-1
% T ... temperature in Kelvin K
% BW ... bandwdith in Hz
% S ... spectral power flux density (flux density) in Jy*10^-26
%
% P = k*T*BW
% P = (1/2)*S*A*BW
% k*T = S*A/2
% S = 2*k*T/A

% Input: 
% temperature in antenna due to fluxdensity load in Kelvin K
% effective area of telescope m^2
%
% Output:
% flux density W/(m^2*Hz) = Jy*10^-26

flux_density = 2*physconst('Boltzmann')*temperature/effective_area;


end