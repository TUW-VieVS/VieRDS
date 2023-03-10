function [s_stat] = statPolToneScan_struc(difx,hops,stat,freq,pol)

Nst=length(stat.c8);
s_stat=struct;
for ist=1:Nst
    pols=struct;
    for ipol=1:2
        tone=struct;
        Ntones=length(difx.(stat.c2{ist}).(pol.label{ipol}));
        for itone=1:Ntones
            
            % databases, A: difx, B: hops
            % A: per station, pol, and tone
            % B: per station
            A=difx.(stat.c2{ist}).(pol.label{ipol})(itone);
            B=hops.(stat.c8{ist});
            
            % index of subband for difx database
            isb=A.sb_id;
            tone(itone).i_subband=isb;
            
            % mathchin pol index in hops database
            id_pol=strfind([B.pol_dir],pol.label{ipol});
            
            % potential mjd in hops database
            MJD=[B(id_pol).mjd];
            
            % number of samples along time axis for tone in difx dtabase
            Ntime=length(A.mjd);
            
            % pre-allocation
            i=1;
            [A_hops,P_hops,F_hops,C_difx,A_difx,P_difx,F_difx,dA,dP,dF,dD,mjd_difx] = preallocate_params;            
            i_scan=1;
            scan=struct;
            [scan.A_hops,scan.P_hops,scan.F_hops,scan.C_difx,scan.A_difx,scan.P_difx,scan.F_difx,scan.dA,scan.dP,scan.dF,scan.dD,scan.mjd_difx] = preallocate_params;
            for itime=1:Ntime
                
                % difx mjd time
                mjd_i=A.mjd(itime);
                
                % date difference between hops and difx, find also minimum
                [dmjd,i_mjd]=min(abs(MJD-mjd_i));
%                 fprintf('%f sec\n',dmjd*60*60*24)
                iB=id_pol(i_mjd);
                
                % if difference is less than 30 sec than a matching scan is found
                if dmjd*60*60*24<30
                    
                    if itime>1
                        if A.scan_id(itime)~=A.scan_id(itime-1)
                            if ~isempty(A_difx)
%                                 ist,ipol,itone,i_scan,itime

                                scan(i_scan) = struct_assignment(A_hops,P_hops,F_hops,C_difx,A_difx,P_difx,F_difx,dA,dP,dF,dD,mjd_difx);
                                i_scan=i_scan+1;
                                [A_hops,P_hops,F_hops,C_difx,A_difx,P_difx,F_difx,dA,dP,dF,dD,mjd_difx] = preallocate_params;
                                i=1;
                            end
                        end
                    end
                    
                    [A_hops(i),P_hops(i),F_hops(i),C_difx(i),A_difx(i),P_difx(i),F_difx(i),dA(i),dP(i),dF(i),dD(i),mjd_difx(i)] = calculate_and_variable_assigment(A,B,iB,isb,itime,freq);
                    
                    i=i+1;
                    
                else
                    
                    warning('something wrong with mjd')
                    fprintf('cannot find difx-hops match: iscan: %d, difx mjd: %f, hops mjd: %f\n',A.scan_id(itime),mjd_i,MJD(iB))
                    
                end
                
            end
            
            DAavg(itone)=mean(dA);
            DPavg(itone)=mean(dP);
            DDavg(itone)=mean(dD);
            %     figure;
            %     plot(dA)
            % plot(dC)
            
            tone(itone).scan=scan;
        end
        pols(ipol).tone=tone;
    end
       
    s_stat(ist).pols=pols;
end
end

