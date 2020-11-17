function checkvdifnumthreads( Nthreads )
% check if number of threads does not exceed limit
if Nthreads > 1024
    warning(' Number of threads in VDIF header exceeds definition limit')
end

end

