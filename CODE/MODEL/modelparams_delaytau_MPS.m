function [tau, signal_arrives_at_station  ] = modelparams_delaytau_MPS(p_tm, sampling_interval, delay_rate_interpolation_interval, delay_rate_interpolation_method, index_for_ptm_signal_arrivaL_time, fa)
% handling of tau

% loop through all reference epochs

% create new struct
p_tm_interpolated = [];

% assign to temp. variable
co = p_tm_interpolated;

% name of ref. epochs
fn = fieldnames(p_tm);

for ire = 1:length(fn)
    
    % assign to temp. variable
    c = p_tm.(fn{ire});
    
    % geocenter delay
    tau_geo = [c(:).tau_geocenter];
    
    % sample delay and sample delay rate (samples/s)
    
    Tx = sampling_interval;
    for i = 1:length(c)
        
        % geocenter delay
        c(i).tau_geocenter = tau_geo(i);
        
        % sample delay
        c(i).sample_tau_geocenter = c(i).tau_geocenter/Tx;
        
        % sample delay rate (samples/s)
        c(i).sample_delay_rate_geocenter = c(i).delay_rate/Tx;
        
        % delay on time interval
        if i ~= length(c)
            c(i).delay_on_interval = c(i).delay_rate*(seconds(c(i+1).datetime-c(i).datetime));
            c(i).delta_delay_on_interval = c(i).delta_delay_rate*(seconds(c(i+1).datetime-c(i).datetime));
        end       
    end
    
    % assign temp. variable back to param struct
    p_tm.(fn{ire}) = c;
    
    % here comes the interpolation section
    % each field of the p_tm struct is interpolated based on the
    % interpolation interval and interpolation method defined in the
    % inputval.m file. the interpolated values are stored in a new struct
    
    % input struct
    ci = p_tm.(fn{ire});
    
    % reference dates
    x = [ci(:).datetime];
    
    % interpolation dates (xq)
    dt = delay_rate_interpolation_interval; % interpolation interval (sec)
    Nq = seconds(x(end)-x(1))/dt; % number of query points
    xq = x(1)+seconds((0:Nq-1)*dt);
    
    % fieldnames to interpolate
    fni = fieldnames(ci);
    
    % loop through all fieldnames
    for ip = 1:length(fni)
        
        % values
        v = [ci(:).(fni{ip})];
        
        % check array size of input values, must be same shape than
        % reference data array size
        [m,n]= size(v);
        if m*n == length(x)
            % interpolate for each parameter and store to new struct
            co.(fn{ire}).(fni{ip}) = interp1(x,v,xq,delay_rate_interpolation_method);
        end
    end
    
end

% assign temp. variable back to param struct
p_tm_interpolated = co;

% delays when wavefront arrives at station
id = index_for_ptm_signal_arrivaL_time;
tau = p_tm.signal_arrival_station_first_sample(id).tau_geocenter;
ntau = p_tm.signal_arrival_station_first_sample(id).sample_tau_geocenter;
dr = p_tm.signal_arrival_station_first_sample(id).delay_rate;

    % determine phase offset at sky frequency
    Tx = sampling_interval;
    [phi0_rad,phi0_sample] = skyFreqPhaseOffset(fa,tau,Tx);

    % re-storage
    signal_arrives_at_station.delay_rate = dr;
    signal_arrives_at_station.sample_delay = ntau;
    signal_arrives_at_station.sample_delay_rounded = round(ntau);
    signal_arrives_at_station.sample_frac_delay = ntau-round(ntau);

    signal_arrives_at_station.phase_offset_fa = phi0_rad;
    signal_arrives_at_station.tau_phase_offset_fa = phi0_sample;
    
end

