function Nch_sum = get_Nch_sum(Nch)

% Get number of defined channels
fn = fieldnames(Nch);
Nst = length(fn);
A = zeros(Nst,1);
for i = 1:Nst
    A(i) = Nch.(fn{i});
end
Nch_sum = sum(A);

end

