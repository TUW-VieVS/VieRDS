function vsum_bbs(vdif_file_name, size, nThread, Thread_Ids, frame_size, frame_rate, Nbit, VDIF_epoch, MDJ_start, second_start, frame_start, second_end, frame_end, first_frame_offset)
% print vdif file summary similar to DiFX "vsum"
% input:
%   vdif_file_name ... vdif file name
%   size ... size in bytes
%   nThread ... number of threads
%   Thread_Ids ... thread Ids
%   frame_size ... frame size (byte)
%   frame_rate ... frame rate
%   Nbit ... bits per sample
%   VDIF_epoch ... vdif epoch
%   MDJ_start ... mjd epoch
%   second_start ... second start
%   frame_start ... frame start
%   second_end ... second end
%   frame_end ... frame end
%   first_frame_offset ... frame offset bytes
% output:
%   (print output)

fprintf('VDIF file: %s\n', vdif_file_name)
fprintf('  size = %.0f bytes\n', size)
fprintf('  nThread = %.0f\n', nThread)
fprintf('  ThreadIds = %.0f\n', Thread_Ids)
fprintf('  frame size = %.0f bytes\n', frame_size)
if isnan(frame_rate)
    fprintf('  frame rate is unknown\n')
end
fprintf('  bits per sample = %.0f\n', Nbit)
fprintf('  VDIF epoch = %.0f\n', VDIF_epoch)
fprintf('  start MJD = %.0f\n', MDJ_start)
fprintf('  start second = %.0f\n', second_start)
fprintf('  start frame = %.0f\n', frame_start)
fprintf('  end second = %.0f\n', second_end)
fprintf('  end frame = %.0f\n', frame_end)
fprintf('  first frame offset = %.0f bytes\n', first_frame_offset)