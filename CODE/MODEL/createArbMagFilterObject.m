function [arb_mag_filter_object] = createArbMagFilterObject(fa,fb,fm,Am,Fx,N,arb_mag_filter_design)
% creates the filter object for arbitrary magnitude filtering
fbw = fb-fa;
fi = fa:Fx:fb;
A = interp1(fm',Am',fi,'pchip');

F = (fi-min(fi))/fbw;

if strcmp(arb_mag_filter_design,'FIR-modeling-with-frequency-sampling-method')
    fprintf('FIR-modeling-with-frequency-sampling-method for arbitrary magnitude filtering will be created\n')
    d = fdesign.arbmag('N,F,A',N,F,A);
    arb_mag_filter_object = design(d,'freqsamp','SystemObject',true);
end

end

