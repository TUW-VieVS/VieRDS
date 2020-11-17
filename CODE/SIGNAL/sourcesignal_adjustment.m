function x = sourcesignal_adjustment(  x, sigma_targetsource, signal_type_target_source )
% source signal adjustment
% adjust source signal to match telescope signal characteristics
%
% Input:
%   Ns ... number of samples
%   sigma_targetsource ... sigma of target source
%   signal_type_target_source ... signal type of target source
%   x ... signal
%
% Output:
%   x_source ... signal of source with scaled amplitude


% adjust other characteristics

% for gaussian-white-noise
if contains(signal_type_target_source,'gaussian-white-noise') 
    
    fprintf('amplitude (%d V) of gaussian white noise is scaled\n', sigma_targetsource)
    
    % central standard distribution
    x = sigma_targetsource * (x - mean(x))/sqrt(var(x));
%     x = sigma_targetsource * x;
else
    warning('signal type is not set to gaussian-white-noise');
end

% ... other

end

