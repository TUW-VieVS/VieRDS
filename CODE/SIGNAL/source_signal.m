function p = source_signal( p )
% creates source signal that is common to all stations
% different types of source signal can be generated
% Input:
%   p ... struct with station common params
%
% Output:
%   p ... struct with station common params
%       new variable: x_source ... time signal of target source

% check for gaussian-white-noise
if strcmp( p.signal_type_target_source, 'gaussian-white-noise')
    % create noise
    p.x_source = gennoise( p.number_of_samples_max );
end

% check for multi-component source (source structure soft)
if strcmp( p.signal_type_target_source, 'here comes a nice name')
    % create noises as a matrix or how to store it?
    % signal type: gaussian-white-noise
    % parameters: number of point-source components
    % delay, delay rate, source flux per station
end

% check for APOD
if strcmp( p.signal_type_target_source , 'APOD' )
        
    T = s.(station_struct_labels{1}).scan_length; % sec
    fs = s.Wn.sampling_frequency; % Hz
    N = T*fs;
    t = 0:1/fs:T-1/fs;
    
    f1  = 8404.870e6;
    f2  = 8420.186e6;
    f   = 8424.015e6;
    f3  = 8427.845e6;
    f4  = 8443.161e6;
    
    A1  = 0.8;
    A2  = 0.8;
    A   = 1;
    A3  = A2;
    A4  = A1;
    
    A = [A1,A2,A,A3,A4];
    f=  ([f1,f2,f,f3,f4]-8402e6)*10^-3;
    
    params.x_targetsource_extended = dortones( A , f , N , fs );
    params.X_targetsource_extended  = fft( params.x_targetsource_extended  );
    X= params.X_targetsource_extended ;
    faxis=0:128/length(X):64-64/length(X)/2;
    figure;plot(faxis,abs(X(1:length(X)/2))/max(abs(X(1:length(X)/2))),'k','LineWidth',6)
    xlabel('Frequency [MHz]','FontSize',20)
    ylabel('Amplitude','FontSize',20)
    xlim([0,64])
    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'FontName','Times','fontsize',20)
end


end

