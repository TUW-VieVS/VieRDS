function [s] = assgin_subband_id(s,freq,pol)

f1=freq.fa;
f2=freq.fb;

POL=pol.label;
for ip=1:2
    ipol=POL{ip};
%     si=s.(['ch_',ipol]);
    for ich=1:length(s.(ipol))
        fi=unique(s.(ipol)(ich).f);
        if length(fi)>1
            warning('something wrong with frequencies')
        end
        isb=find(fi>=f1 & fi<=f2);
        s.(ipol)(ich).sb_id=isb;
    end
end





end

