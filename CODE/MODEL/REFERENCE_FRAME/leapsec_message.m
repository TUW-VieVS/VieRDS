function leapsec_message(t_obs, t_leap_most_recent)
% message to look for new leap second entry
%
% input:
%   t_obs ... date of observation [mjd]
%   t_leap_most_recent ... date of most recent leap second entry [mjd]
%
% output:
%   -

% display warning if time of interest is after most recent leap second entry
if t_obs > t_leap_most_recent
    fprintf('please check for new leap second TAI-UTC tai_utc.m:\n')
    fprintf('  last leap sec: %5.0f [mjd]\n',t_leap_most_recent)
    fprintf('  date of observation: %5.0f [mjd]\n',t_obs)
end

end

