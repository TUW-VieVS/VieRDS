function [p] = modelparams_noise_arbmag(p)
% calculates model params for arbitrary filter magnitude filter response

fn = fieldnames(p);

for ifn = 1:length(fn)
    
    a = fn{ifn};
    
    if contains(fn{ifn},'arb_mag_file')
        id = str2double(a(length('arb_mag_file')+2:end));
        
        % create arbitrary magnitude filter object
        fa = p.fa;
        fb = p.fb;
        fm = p.(['arb_mag_f_',num2str(id)]);
        Am = p.(['arb_mag_A_',num2str(id)]);
        Fx = p.(['arb_mag_interpolation_res_',num2str(id)]);
        N = p.(['arb_mag_filter_order_',num2str(id)]);
        arb_mag_filter_design = p.(['arb_mag_filter_design_',num2str(id)]);
        
        p.(['arb_mag_filter_object_',num2str(id)]) = createArbMagFilterObject(fa,fb,fm,Am,Fx,N,arb_mag_filter_design);
        
        
    end

    % in case arbitrary magnitude filter object should be created
%     if create_filter == 1
%         fa = p.fa;
%         fb = p.fb;
%         fbw = fb-fa;
%         fm = p.arb_mag_f;
%         Am = p.arb_mag_A;
%         Fx = p.arb_mag_interpolation_res;
%         fi = fa:Fx:fb;
%         A = interp1(fm',Am',fi,'pchip');
%         N = p.arb_mag_filter_order;
% 
%         F = (fi-min(fi))/fbw;
% 
%         if strcmp(p.arb_mag_filter_design,'FIR-modeling-with-frequency-sampling-method')
%             fprintf('FIR-modeling-with-frequency-sampling-method for arbitrary magnitude filtering will be created\n')
%             d = fdesign.arbmag('N,F,A',N,F,A);
%             p.arb_mag_filter_object = design(d,'freqsamp','SystemObject',true);
%         end
% 
%     %     fvtool(p.arb_mag_filter_object,'MagnitudeDisplay','Zero-phase','Color','White');
% 
%     end
    
end


end

