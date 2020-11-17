function vdif_file_name = create_vdif_filename(stname, fs, NBit, NCh, T, special_label)
% create vdif file name
% input:
%   stname ... station name (string)
%   fs ... sampling rate [MHz] (double)
%   NBit ... number of bits (double)
%   NCh ... number of channels (double)
%   T ... scan duration (double)
%   special_label ... special label (string)

d = '_';
vdif_file_ending = '.vdif';

vdif_file_name = [ stname, d, num2str(fs), d, num2str(NBit), d, num2str(NCh), d, num2str(T), d, special_label, vdif_file_ending ];

end

