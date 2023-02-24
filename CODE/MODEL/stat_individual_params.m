function s = stat_individual_params( s, controling, ref_frame )
% calculates all relevant station individual parameters
% Input:
%   s ... single station struct
%   controling ... controling struct
%   ref_frame ... reference frame struct
% Output:
%   s ... single station struct (with all relevant station individual paramaters)

% station input --> SI units
s = input2si(s);

% partners
s = partner(s);

% basic model params
s = modelparams_basics(s);

% MPS channel allocation
[outputArg1,outputArg2] = mps2channel(s.fa, s.fb, s.multi_point_source_data(:,1), s.multi_point_source_data(:,2));

% exception handling
s = exchandling(s);

% coordinate reference frame
if ~isempty(fieldnames(ref_frame))
    
    % calculate station models params based on reference database
    s = modelparams_referenceframe(s, ref_frame, controling);
    
else
    
    % zero baseline: set all kinematic params to zero to avoid any impact of earth-orientation affects
    % define p_tm params and make things clearer in code
%     warning('make sure all parameters that are created within modelparams_referenceframe are also specified in zero_kinematics');
    s.p_tm = zero_kinematic( s );
    s.signal_arrival_time = 0;
    s.signal_arrival_time_offset = 0;
    s.index_for_ptm_signal_arrivaL_time = 1;
    s.signal_arrival_time_offset = 0;
    
    EOP_vex = load('default_eop_vex.mat');
    EOP_vex = EOP_vex.EOP_vex;
    EOP_vex.MJD = EOP_vex.mjd;
    EOP_vex.mjd = [];
    EOP_vex.year = [];
    EOP_vex.doy = [];
    for im = 1:length(EOP_vex.MJD)
        EOP_vex.mjd(im) = floor(s.date_mjd) - 5 + im-1;
        EOP_vex.year(im) = s.date_vec(1);
        EOP_vex.doy(im) = s.doy-5+im-1;
    end
    s.EOP_vex = EOP_vex;
    s.X_trf = [4.0755139837000000e+06,9.317353092000000e+05,4.801629401000000e+06];
    s.s_crf_sph = [1,0];
    
end

% models
s = modelparams(s);

end

