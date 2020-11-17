function [P] = readArbMagRespSingle(P)
% read single arbitrary magnitude response file

% input:
%   P ... simulation struct
%
% output:
%   P ... updated station struct with arbitrary magnitude response values

NSIM = length(P);

for isim = 1:NSIM
    
    % assing station SIM struct to new variable
    p = P{isim,1};
    
    
    [ St, Nst ] = station_struct_label( p );
    
    
    for iSt = 1:Nst
        
        pj = p.(St{iSt});
        
        fn = fieldnames(pj);
        
        for iFn = 1:length(fn)
            a = fn{iFn};
            if contains(a, 'arb_mag_file')
                
                i = str2double(a(length('arb_mag_file')+2:end));
                
                if isnan(i)
                    warning('Something wrong with your arbitrary magnitude paramter label in your yaml input file. Please end your label with a number, e.g.   arb_mag_file_1: arbmag.txt.')
                end
                
                arb_mag_file = ['arb_mag_file_',num2str(i)];
                arb_mag_f = ['arb_mag_f_',num2str(i)];
                arb_mag_A = ['arb_mag_A_',num2str(i)];
                
                arb_mag_interpolation_res_i = ['arb_mag_interpolation_res_',num2str(i)];
                arb_mag_filter_order_i = ['arb_mag_filter_order_',num2str(i)];
                arb_mag_filter_design_i = ['arb_mag_filter_design_',num2str(i)];
                arb_mag_filter_signal_type_i = ['arb_mag_filter_signal_type_',num2str(i)];
                
                if ~isfield(pj,arb_mag_interpolation_res_i)
                    fprintf('assign default arbitrary magnitude interpolation resolution to arb_mag_file: %d\n',i)
                    P{isim,1}.(St{iSt}).(arb_mag_interpolation_res_i) = P{isim,1}.(St{iSt}).arb_mag_interpolation_res;
                end
                
                if ~isfield(pj,arb_mag_filter_order_i)
                    fprintf('assign default arb_mag_filter_order to arb_mag_file: %d\n',i)
                    P{isim,1}.(St{iSt}).(arb_mag_filter_order_i) = P{isim,1}.(St{iSt}).arb_mag_filter_order;
                end
                
                if ~isfield(pj,arb_mag_filter_design_i)                    
                    fprintf('assign default arb_mag_filter_design to arb_mag_file: %d\n',i)
                    P{isim,1}.(St{iSt}).(arb_mag_filter_design_i) = P{isim,1}.(St{iSt}).arb_mag_filter_design;
                end
                
                if ~isfield(pj,arb_mag_filter_signal_type_i)                    
                    fprintf('assign default arb_mag_filter_signal_type to arb_mag_file: %d\n',i)
                    P{isim,1}.(St{iSt}).(arb_mag_filter_signal_type_i) = P{isim,1}.(St{iSt}).arb_mag_filter_signal_type;
                end
                
                amf = pj.(arb_mag_file);
                
                if isempty(amf)
                    read_in = 0;
                else
                    read_in = 1;
                end
                
                if read_in == 1
                    D = dlmread(amf);
                    fprintf('convert arbitrary magnitude frequency from GHz to Hz\n')
                    P{isim,1}.(St{iSt}).(arb_mag_f) = D(:,1)*1e9;
                    P{isim,1}.(St{iSt}).(arb_mag_A) = D(:,2);
                end
                
                
            else
                
            end
        end
        
        
    end
end

end

