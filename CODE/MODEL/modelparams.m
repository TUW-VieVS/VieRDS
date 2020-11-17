function [ params ] = modelparams( params )
% Used to calculate model parameters

% basics
params = modelparams_basics(params);

% phase calibration
params = modelparams_phasecal(params);  

% arbitrary magnitude response
[params] = modelparams_noise_arbmag(params);

% power 
params = modelparams_power(params);

% delay (time dependent)
[params] = modelparams_delaytau(params);

end

