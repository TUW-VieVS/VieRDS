function x_ideal = signal_superposition_station(x_source, x_system, x_pcal)
% superposition of station signals
% input:
%   x_source ... adjusted source signal
%   x_system ... system noise
%   x_pcal ... pcal siganl
%   x_test ... test signal
% method:
%   superposition of signals in the time domain
% output:
%   x_ideal ... signal consisting of all components without filtering

% create cell array with all signal components
x_cell = {x_source, x_system, x_pcal};

% preallocate
x_ideal = zeros(1,length(x_source));

% loop through cell array
for i = 1:length(x_cell)
    
    % superimpose if signal component is NOT empty
    if ~isempty(x_cell{i})    
        
        % superimpose
        x_ideal = x_ideal + x_cell{i};
        
    end
    
end

end