function printTable4DoubleSourceIdRange(true,T,type_delay,data_set_id)

if strcmp(type_delay, 'mbd')
    fprintf('Delay Type: Multiband delay:\n')
end

fn = fieldnames(T);


fprintf('displacement (mas), true delay 1 (ps), true delay 2 (ps), avg. true (ps), estimated delay (ps), true-est. (ps), sample variance (ps), theoretical variance (ps), average snr, number of samples\n')

% i = data_set_id;
for i = data_set_id

    % true delta Ra, De
    displacement(i) = true.deltaRaDe(i);

    % true delay (ps)
    true_1(i) = true.delay(1)*10^3;

    % true delay (ps)
    true_2(i) = true.delay(i)*10^3;

    % true delay (ps)
    true_0(i) = mean([true_1(i),true_2(i)]);
    
    % average fourfit mbd (ps)
    est(i) = T.(fn{i}).stats.two.(type_delay).avg*10^6;
    
    % diff (ps)
    dest(i) = true_0(i)-est(i);
    
    % sigma fourfit mbd (ps)
    err(i) = T.(fn{i}).stats.two.(type_delay).sig*10^6;

    % theory variance (ps)
    err_theory(i) = T.(fn{i}).stats.two.(type_delay).sig_theory*10^6;
    
    % average snr
    snr_avg(i) = T.(fn{i}).stats.two.snr.avg;
    
    % number of samples
    N(i) = T.(fn{i}).stats.two.N;
    
    fprintf('%1.1f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.2f, %d\n',displacement(i), true_1(i), true_2(i), true_0(i), est(i), dest(i), err(i), err_theory(i), snr_avg(i), N(i))
end

end