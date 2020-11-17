function printvdifsum( params , headerspec , headerframes  )

fprintf('  VDIF file: %s\n', params.file_name )
fprintf('\tsize = %d bytes\n' , params.filesize_bit / 8 )
fprintf('\tnThread = %d\n' ,  headerspec.thread_id+1 )
fprintf('\tThread Ids = %d\n' , headerspec.thread_id )
fprintf('\tframe size = %d bytes\n' , params.frame_length_byte )
fprintf('\tframe rate is unkown\n')
fprintf('\tbits per sample = %d\n' , params.number_of_bits_per_sample )
fprintf('\tVDIF epoch = %d\n' ,  headerframes.hyf2000(1))
fprintf('\tstart MJD = %.8f\n' , params.mjd )
fprintf('\tstart second = %d\n' , params.date_vec(6) )
fprintf('\tstart frame = 0\n')
fprintf('\tend second = %d\n' , params.date_vec(6) + params.scan_duration )
fprintf('\tend frame = %d\n' , headerspec.number_of_frame_within_sec )
fprintf('\n')
fprintf('%s %.8f %.8f\n' , params.file_name , params.mjd , params.mjd_end )


end

