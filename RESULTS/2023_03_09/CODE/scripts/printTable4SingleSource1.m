function printTable4SingleSource1(true,T,type_delay,data_set_id)

if strcmp(type_delay, 'mbd')
    fprintf('Delay Type: Multiband delay:\n')
end

fn = fieldnames(T);
i = data_set_id;
fprintf('Dataset: %s\n\n',fn{i})


fprintf('true delay (ps), estimated delay (ps), true-est. (ps), sample standard deviation (ps), theoretical standard deviation (ps), average snr, number of samples\n')


% true delay (ps)
x2=true.delay(i)*10^3;

% average fourfit mbd (ps)
x3 = T.(fn{i}).stats.one.(type_delay).avg*10^6;

% diff
x4 = x2-x3;

% sigma fourfit mbd (ps)
x5 = T.(fn{i}).stats.one.(type_delay).sig*10^6;

% theory variance (ps)
x6 = T.(fn{i}).stats.one.(type_delay).sig_theory*10^6;

% average snr
x8 = T.(fn{i}).stats.one.snr.avg;

% number of samples
x10 = length(T.(fn{i}).one);

fprintf('%.3f, %.3f, %.3f, %.3f, %.3f, %.2f, %d\n',x2, x3, x4, x5, x6, x8, x10)

end