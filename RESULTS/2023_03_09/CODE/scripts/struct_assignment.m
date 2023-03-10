function [s] = struct_assignment(A_hops,P_hops,F_hops,C_difx,A_difx,P_difx,F_difx,dA,dP,dF,dD,mjd_difx)
% hops
s.A_hops=A_hops;
s.P_hops=P_hops;
s.F_hops=F_hops;

% difx
s.C_difx=C_difx;
s.A_difx=A_difx;
s.P_difx=P_difx;
s.F_difx=F_difx;

% delta
s.dA=dA;
s.dP=dP;
s.dF=dF;
s.dD=dD;


s.mjd_difx=mjd_difx;
end

