function checkSamples( samples , params )

% check size of samples
[ dataset.number_of_channels , dataset.num_samples_file ] = size( samples );
if dataset.number_of_channels ~= params.number_of_channels
    fprintf('  Number of channels in dataset: %d\n' , dataset.number_of_channels )
    fprintf('  Number of channels specified in input: %d\n' , params.number_of_channels )
    error('Number of channels in dataset with specified via input does NOT match')
end
if dataset.num_samples_file ~= params.num_samples_file
    fprintf('  Number of samples in dataset: %d\n' , dataset.num_samples_file )
    fprintf('  Number of samples calculated with input params: %d\n' , params.num_samples_file )
    error('Number of samples in dataset with specified via input does NOT match')
end

% check range of values of samples
for id_ch = 1:dataset.number_of_channels
    min_samples = min(samples(id_ch,:));
    max_samples = max(samples(id_ch,:));
    if min_samples < 0
        error('Negative values within samples');
    end
    d = max_samples - min_samples;
    if d > 2^params.number_of_bits_per_sample
        fprintf(' Range of values input: %f, min: %f max: %f\n' , d , min_samples , max_samples )
        fprintf(' Number of bit: %f\n',2^params.number_of_bits_per_sample)
        error('Range of values is to large for specified input')
    end
end

end

