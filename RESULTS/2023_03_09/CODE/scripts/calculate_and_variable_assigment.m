function [A_hops,P_hops,F_hops,C_difx,A_difx,P_difx,F_difx,dA,dP,dF,dD,mjd_difx] = calculate_and_variable_assigment(A,B,iB,isb,itime,freq)
% hops
A_hops=B(iB).pcal_ampl(isb);
P_hops=deg2rad(B(iB).pcal_phase(isb));
F_hops=freq.f0(isb);

% difx
C_difx=A.C(itime);
A_difx=abs(A.C(itime));
P_difx=phase(A.C(itime));
F_difx=A.f(itime);

% delta
dA=A_difx-A_hops;
dP=P_difx-P_hops;
dF=F_difx-F_hops;
dD=dP/(2*pi*dF);

mjd_difx=A.mjd(itime);
end

