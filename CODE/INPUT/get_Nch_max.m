function Nch_max = get_Nch_max(Nch)
% Get number max number of channels 

fn = fieldnames(Nch);
Nst = length(fn);
A = zeros(Nst,1);
for i = 1:Nst
    A(i) = Nch.(fn{i});
end
Nch_max = max(A);

end

