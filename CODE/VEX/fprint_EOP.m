function fprint_EOP(fileID, EOP)
%   EOP ... struct with:
%               mjd
%               xp_arcsec
%               yp_arcsec
%               dut1
%               leap
%               date
%               year
%               doy

% number of EOP
N_EOP = length(EOP.mjd);
% if N_EOP ~= 5
%     warning('5 EOPS are writte to the vex file. But could be %d. DIFX can handle more, but difx2fits are limited to 5',N_EOP)
% end

fprintf(fileID, '$EOP;\n');
for i_EOP = floor(N_EOP/2)-2:floor(N_EOP/2)+2
    fprintf(fileID, '  def EOP%d;\n',EOP.doy(i_EOP));
    fprintf(fileID, '    TAI-UTC=%d sec;\n',EOP.leap(i_EOP));
    fprintf(fileID, '    A1-TAI=0 sec; * hard coded\n');
    fprintf(fileID, '    eop_ref_epoch=%dy%dd;\n',EOP.year(i_EOP), EOP.doy(i_EOP) );
    fprintf(fileID, '    num_eop_points=1; * hard coded\n');
    fprintf(fileID, '    eop_interval=24 hr; * hard coded\n');
    fprintf(fileID, '    ut1-utc =%g sec;\n',EOP.dut1(i_EOP));
    fprintf(fileID, '    x_wobble =%g asec;\n',EOP.xp_arcsec(i_EOP));
    fprintf(fileID, '    y_wobble =%g asec;\n',EOP.yp_arcsec(i_EOP)); 
    fprintf(fileID,'  enddef;\n');
end

end

