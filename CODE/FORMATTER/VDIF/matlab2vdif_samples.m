function sampels = matlab2vdif_samples(sampels)
% convert range of values from matlab to vdif
% input:
%   matlab_samples
% output:
%   vdif_samples
% method:
%   lowest value of vdif samples is zero

sampels = sampels + abs(min(sampels(:)));

end

