function [c] = calcRelTauParams(c,refval)
% calculate relative params w.r.t to first station in array and first point
% source 

% list of params which can be used for relative parameter
% estimation
relative_params = {'tau','delay_rate','phase_offset_fa','tau_phase_offset_fa'};

% number of relative params
Nrp = length(relative_params);

% calculate relative params for each one
for irp = 1:Nrp
    % name of relative param
    delta_relative_param = ['d',relative_params{irp}];

    % calculate delta
    c.(delta_relative_param) = refval.(relative_params{irp}) - c.(relative_params{irp});

    if strcmp(relative_params{irp}, 'tau')
        fprintf('Relative delay: %f (ns)', c.(delta_relative_param)*10^9)
    end
end

