function t_m = get_timemodel_ref_dates( t_a, t_b, T_m, dt_m, adjustable_offset, ref_point_type )
% get dates at which kinematic values will be calculated
%
% input:
%   t_a ... start of scan [datetime]
%   t_b ... end of scan [datetime]
%   T_m ... time period before and after t_m_a,b [sec]
%   dt_m ... time-intervall of discretistation between t_m_a and t_m_b [sec]
%   adjustable_offset ... adjustable time offset from scan start [sec]
%   ref_point_type ... string to define which kind of reference point(s) will be estimated
%       possible inputs:
%           scan-start ... reference point will be set to scan start
%           scan-middle ... reference point will be set to middel of scan
%           scan-end ... reference point will be set to end of scan
%           adjustable ... referene point will be set to adjustable offset of scan start
%           multiple ... multiple reference points will be used 
%
% output:
%   t_m ... model time vector

% assing femto seconds precision to dates
t_a = datetime(t_a,'Format','dd-MMM-yyyy HH:mm:ss.SSSSSSSSSSSSSSS');
t_b = datetime(t_b,'Format','dd-MMM-yyyy HH:mm:ss.SSSSSSSSSSSSSSS');


% preallocate t_m
t_m = [];

% start of scan
if strcmp(ref_point_type, 'scan-start')

    % set to start of scan
    t_m = t_a;

end

% middle of scan
if strcmp(ref_point_type, 'scan-middle')
    
    % set to middle of scan
    t_m = t_a+(t_b-t_a)/2;
    
end

% end of scan
if strcmp(ref_point_type, 'scan-end')

    % set to end of scan
    t_m = t_b;
    
end

% adjustable
if strcmp(ref_point_type, 'adjustable')
    
    % set to adjustable reference point
    t_m = t_a + seconds(adjustable_offset);
    
end

% multiple
if strcmp(ref_point_type, 'multiple')
    
    % create vector of t_m
    t_m = time_model_vector(t_a, t_b, T_m, dt_m);
    
end

% check if any ref model has been choosen
if isempty(t_m)
    warning('No valid reference time model type has been choosen --> input_val.yaml/inputval.m');
end

end

