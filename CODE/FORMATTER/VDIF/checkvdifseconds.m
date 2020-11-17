function checkvdifseconds( sec_from_ref_epoch )
% checks if number of seconds exceeds half year

if sec_from_ref_epoch > 60*60*24*(365/2)
    warning('Number of seconds exceeds half year')
end

end

