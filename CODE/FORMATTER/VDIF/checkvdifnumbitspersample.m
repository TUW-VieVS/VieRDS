function checkvdifnumbitspersample( Nbit )
% Check if number of bits per sample is valid for vdif header definitions
if Nbit > 32
    warning('Number of bits per sample exceeds limit')
end

end

