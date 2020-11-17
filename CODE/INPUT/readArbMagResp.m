function [P] = readArbMagResp(P)
% reads multiple arbitrary magnitude response files
%
% input:
%   P ... simulation struct
%
% output:
%   P ... updated station struct with arbitrary magnitude response values


[P] = readArbMagRespSingle(P);


end

