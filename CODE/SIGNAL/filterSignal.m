function [x] = filterSignal(x,p)
% filter source signal
%
% input:
%   x ... input signal
%   p ... station parameter struct

% no filter
if strcmp(p.bandpass_filter_name,'none')
    
    fprintf('no filter applied\n')
    
end

% default bandpass filter
if strcmp(p.bandpass_filter_name,'default')
    
    fprintf('default band pass filter will be applied\n')
    
    N = p.bandpass_number_of_filter_coefficients;
    ca = p.bandpass_fa_cutoff_perc;
    cb = p.bandpass_fb_cutoff_perc;
    
    % window filter
    [b,a] = fir1(N,[ca,cb],'bandpass');
    ntaps = length(b);
    x = filter(b,a,x);
    x = circshift(x,-(ntaps-1)/2);
end

% arbitrary magnitude filter

fn = fieldnames(p);

% loop through fieldnames
for ifn = 1:length(fn)
    
    % current field name
    a = fn{ifn};
    
    % look for arbitrary magnitude filter signal type
    if contains(a,'arb_mag_file')
        % get id
        id = a(length('arb_mag_file')+2:end);
        
        % signal type
        sig_type = p.(['arb_mag_filter_signal_type_',id]);
        
        if strcmp(sig_type, 'super')
            fprintf('arbitrary magnitude filter will be applied on all signal components: %s\n',sig_type)
            
            b = ['arb_mag_filter_object_',id];
            x = filter(p.(b).Numerator,1,x);
            
            ntaps = length(p.(b).Numerator);
            x = circshift(x,-(ntaps-1)/2);
        end
    end
end

