function [yes_match,no_match] = find_corresponding_channels(freq_range_matrix, Nch_sum)
% find corresponding channels

no_match = {};
i_no_match = 0;
yes_match = {};
i_yes_match = 0;
yes_match_i_ch = [];
for i_ch = 1:Nch_sum
    if ~isempty(find(i_ch==yes_match_i_ch, 1))
        continue
    end
    fa = freq_range_matrix(i_ch,1);
    fb = freq_range_matrix(i_ch,2);
    i_match_case_1 = fa<=freq_range_matrix(:,1) & fb>=freq_range_matrix(:,2);
    i_match_case_2 = fa>=freq_range_matrix(:,1) & fb<=freq_range_matrix(:,2);
    i_match_case_3 = fa>=freq_range_matrix(:,1) & fb>=freq_range_matrix(:,2) & fa<=freq_range_matrix(:,2);
    i_match_case_4 = fa<=freq_range_matrix(:,1) & fb<=freq_range_matrix(:,2) & fb>= freq_range_matrix(:,1);
    ind_match = find(i_match_case_1 | i_match_case_2 | i_match_case_3 | i_match_case_4);
    if length(ind_match)>=2
        i_yes_match = i_yes_match +1;
        yes_match{i_yes_match,1} = freq_range_matrix(ind_match,3);
        yes_match{i_yes_match,2} = freq_range_matrix(ind_match,4);
        yes_match{i_yes_match,3} = freq_range_matrix(ind_match,1);
        yes_match{i_yes_match,4} = freq_range_matrix(ind_match,2);
        yes_match_i_ch = [yes_match_i_ch;freq_range_matrix(ind_match,5)];
    else
        i_no_match = i_no_match +1;
        no_match{i_no_match,1} = freq_range_matrix(ind_match,3);
        no_match{i_no_match,2} = freq_range_matrix(ind_match,4);
        no_match{i_no_match,3} = freq_range_matrix(ind_match,1);
        no_match{i_no_match,4} = freq_range_matrix(ind_match,2);        
    end
end

if ~isempty(yes_match)

    fprintf('Multi channel simulations:\n');
    for i_ch = 1:length(yes_match(:,1))
        fprintf('\tMatch %d:\n',i_ch)
        for i_mch = 1:length(yes_match{i_ch,1})
            fprintf('\t\tstation: %d channel: %d freq: %d - %d MHz\n', yes_match{i_ch,1}(i_mch), yes_match{i_ch,2}(i_mch), yes_match{i_ch,3}(i_mch), yes_match{i_ch,4}(i_mch))
        end
    end
end

if ~isempty(no_match)
    fprintf('Single dish simulations:\n')
    for i_no = 1:length(no_match(:,1))
        fprintf('\tSingle dish %d:\n',i_no)
        fprintf('\t\tstation: %d channel: %d freq: %d - %d MHz\n', no_match{i_no,1}, no_match{i_no,2}, no_match{i_no,3}, no_match{i_no,4})    
    end

end

