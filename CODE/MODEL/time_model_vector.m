function t_m = time_model_vector(t_a, t_b, T_m, dt_m)
% creates a time vector which covers and contains the scan time
% 
% input:
%   t_a ... start of scan [datetime]
%   t_b ... end of scan [datetime]
%   T_m ... time period before and after t_m_a,b [sec]
%   dt_m ... time-intervall of discretistation between t_m_a and t_m_b [sec]
%
% output:
%   t_m ... model time vector

% t_a: datetime to datevec
t_a_vec = datevec(t_a);

% t_b: datetime to datevec;
t_b_vec = datevec(t_b);

% if T_m is zero no worries
if T_m ~= 0

    % check if T_m is too short (<1s)
    if T_m < 1
        warning('Time model for parameter calculation, time period T_m is smaller than 1 sec')
    end

    % check if T_m is non-integer value
    if mod(T_m, 1) ~= 0
        warning('time period T_m (time-model) is non integer value')
    end
end

% check if dt_m is too large
if dt_m > etime(t_b_vec, t_a_vec)
    warning('dt_m (time-model) is larger than scan time')
end

% check if 1 sec is integer multiple dt_m for dt_m < 1
if dt_m < 1
    if mod(1,dt_m) ~= 0
        warning('dt_m (time-model) is non integer divisor of 1 sec')
    end
end

% check if dt_m is integer multiple 1 sec for dt_m > 1
if dt_m > 1
    if mod(dt_m, 1) == 0
        warning('dt_m (time-model) is non integer multiple of 1 sec')
    end
end

% round t_a to sec (floor)
t_a_sec = floor(t_a_vec);

% round t_b to sec (ceil)
t_b_sec = ceil(t_b_vec);

% start of model vector
t_m_a = datetime(t_a_sec, 'Format', 'yyyy-MM-dd  HH:mm:ss.SSSSSS') - seconds(T_m);

% end of model vector
t_m_b = datetime(t_b_sec, 'Format', 'yyyy-MM-dd  HH:mm:ss.SSSSSS') + seconds(T_m);

% model time vector
t_m = t_m_a:seconds(dt_m):t_m_b;
t_m = t_m(1:end-1); % ... because it belongs to start of interval




