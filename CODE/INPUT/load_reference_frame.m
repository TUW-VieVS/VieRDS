function r = load_reference_frame(parameter)
% reads trf and crf coordinates from database and stores it into a struct

r = struct;

% load data from trf and crf databases
[r.trf, r.crf, ~] = get_trf_and_crf(parameter);

% remove empty lines from trf and crf
r.trf(cellfun(@length,{r.trf.code})<1) = [];
r.crf(cellfun(@length,{r.crf.IVSname})<1) = [];

% 2 letter code without white-spaces
r.lc2 = {strrep({r.trf.code},' ','')};

% IVS name without white-spaces
r.IVS_source_name = {strrep({r.crf.IVSname},' ','')};

end

