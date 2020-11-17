function s = combine_structs(s,b)
% combine two structs
% existing fields in s will be overwritten by b field values
% if a field in b exists but in s not, a new field will b created

b_fn = fieldnames(b);
for i=1:length(b_fn)
    if isstruct(b.(b_fn{i}))
        b_sub_fn = fieldnames(b.(b_fn{i}));
        for j=1:length(b_sub_fn)
            s.(b_fn{i}).(b_sub_fn{j})=b.(b_fn{i}).(b_sub_fn{j});
        end
    else
        s.(b_fn{i}) = b.(b_fn{i});
    end
end

end

