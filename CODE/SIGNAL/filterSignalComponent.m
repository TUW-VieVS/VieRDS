function [p] = filterSignalComponent(p)
% filter individual signal component

% fieldnames
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
       
        if strcmp(sig_type, 'source')
            fprintf('arbitrary magnitude filter will be applied on signal component: %s\n',sig_type)
            
            b = ['arb_mag_filter_object_',id];
            p.x_source = filter(p.(b).Numerator,1,p.x_source);
    
            ntaps = length(p.(b).Numerator);
            p.x_source = circshift(p.x_source,-(ntaps-1)/2);
        end
        
        if strcmp(sig_type, 'system')
            fprintf('arbitrary magnitude filter will be applied on signal component: %s\n',sig_type)
            
            b = ['arb_mag_filter_object_',id];
            p.x_system = filter(p.(b).Numerator,1,p.x_system);
    
            ntaps = length(p.(b).Numerator);
            p.x_system = circshift(p.x_system,-(ntaps-1)/2);
        end
        
        if strcmp(sig_type, 'pcal')
            fprintf('arbitrary magnitude filter will be applied on signal component: %s\n',sig_type)
            
            b = ['arb_mag_filter_object_',id];
            p.x_system = filter(p.(b).Numerator,1,p.x_system);
    
            ntaps = length(p.(b).Numerator);
            p.x_system = circshift(p.x_system,-(ntaps-1)/2);
        end
        
    end
    
    
end


end

