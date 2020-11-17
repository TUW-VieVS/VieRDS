% #########################################################################
% #     load_eop
% #########################################################################
%
% DESCRITPION
% This function loads EOP data from text files and returns EOP vectors.
% 
% Please note:
% In case of "eop_txt_file_vievs" the last 5 EOP values of the input time sereis are taken instead of EOP values of the last 5 days!
%
% AUTHOR 
%   A. Hellerschmied, 2017-03-20
%
% INPUT
% - MJD            : Observation epochs [MJD]
% - parameter      : VieVS parameter structure
%
% OUTPUT
% - mjd             : MJD reference epoch
% - xp              : pole coordinates [rad]
% - yp              : pole coordinates [rad]
% - dut1            : UT1-UTC [sec]
% - dX              : Cel. pole offsets [rad]
% - dY              : Celestial pole offsets [rad]
% - leap            : leap seconds [sec]
%
% CHANGES
% - 2017-08-29: A. Girdiuk: in case of "eop_txt_file_vievs" the last 5 EOP values of the input time series are taken instead of EOP values of the last 5 days!
%

function [mjd, xp_rad, yp_rad, dut1_sec, dX_rad, dY_rad, leap] = load_eop(MJD, EOP_file)

% additional EOP file naming options
eop_dir_str = '';

% constant to convert [mas] to [rad]
mas2rad_const = (1/1000) * (pi/180) * (1/3600);

% constant to convert [as] to [rad]
as2rad_const  = (pi/180) * (1/3600);

% distinguish between different input files
switch(EOP_file)
    
    % EOP C04 14 (IERS format)
    case 'C04_14_1962_now.txt' 
        eop_file_type_str = 'C04_14_iers';
        eop_file_str      = [eop_dir_str, 'C04_14_1962_now.txt'];
            
    % EOP C04 08 (IERS format)
    case 'C04_08_1962_now.txt' 
        eop_file_type_str = 'C04_08_iers';
        eop_file_str      = [eop_dir_str, 'C04_08_1962_now.txt']; 
        
    % EOP C04 05 (IERS format)    
    case 'C04_05_1962_now.txt' 
        eop_file_type_str = 'C04_05_iers';
        eop_file_str      = [eop_dir_str, 'C04_05_1962_now.txt'];
        
    % EOP finals file (IERS format)
    case 'finals_all_IAU2000.txt'
        eop_file_type_str = 'finals_iers';
        eop_file_str      = [eop_dir_str, 'finals_all_IAU2000.txt'];
    
    % EOP finals file (VieVS format)
    case 'finals_all_IAU2000_vievs.txt' 
        eop_file_type_str = 'finals_vievs';
        eop_file_str      = [eop_dir_str, 'finals_all_IAU2000_vievs.txt'];
    
    % EOP text file (VieVS formatted) 
    otherwise 
        eop_file_type_str = 'eop_txt_file_vievs';
        eop_file_str      = [eop_dir_str, EOP_file];
end

% print file name which will be loaded
fprintf(1, 'Loading EOP file: %s\n', eop_file_str);

% get start EOP epoch: -5 days before ref. MJD
mjd_min = floor(min(MJD)) - 5;

% get stop EOP eopch: +5 days after ref. MJD
mjd_max = ceil(max(MJD)) + 5;

% load data from EOP files
switch(eop_file_type_str)
    
    % in case of C04 input
    case {'C04_14_iers', 'C04_08_iers', 'C04_05_iers'}
               
        % open file
        fid = fopen(eop_file_str);
        
        % error if cannot open
        if fid == -1
            error('Failed to open EOP file: %s\n', eop_file_str);
        end
        
        % read data from file
        eop_data = textscan(fid, '%d %d %d %f %f %f %f %f %f %f %*[^\n]', 'HeaderLines', 14);
        
        % close file
        fclose(fid);
        
        % get epoch indices (fourth entry represents mjd)
        mjd = eop_data{4};
        
        % index: find mjd which are in area of interest
        mjd_ind = (mjd >= mjd_min) & (mjd <= mjd_max);
        
        % check, if EOP data is available for the observation epochs
        if sum(mjd >= mjd_max) == 0
            error('No EOP data available for observation epochs (+-5 days for interpolation)! EOP file: %s', eop_file_str);
        end
        
        % prepare data vectors
        mjd       = mjd(mjd_ind);
        xp_arcsec = eop_data{5};
        xp_arcsec = xp_arcsec(mjd_ind);
        yp_arcsec = eop_data{6};
        yp_arcsec = yp_arcsec(mjd_ind);
        dut1_sec  = eop_data{7};
        dut1_sec  = dut1_sec(mjd_ind);
        dX_arcsec = eop_data{9};
        dX_arcsec = dX_arcsec(mjd_ind);
        dY_arcsec = eop_data{10};
        dY_arcsec = dY_arcsec(mjd_ind);
        
        % unit conversions
        xp_rad = xp_arcsec * as2rad_const;
        yp_rad = yp_arcsec * as2rad_const;
        dX_rad = dX_arcsec * as2rad_const;
        dY_rad = dY_arcsec * as2rad_const;
        
        
    case 'finals_iers'
        
        % Open file:
        fid = fopen(eop_file_str);
        if fid == -1
            error('Failed to open EOP file: %s\n', eop_file_str);
        end
        
        % Read data:
        eop_data = textscan(fid, '%2c%2c%2c%1c%8c%1c%1c%1c%9c%9c%1c%9c%9c%2c%1c%10c%10c%1c%7c%7c%2c%1c%1c%9c%9c%1c%9c%9c%10c%10c%11c%10c%10c%*[^\n]', 'Whitespace', '');
        
        % Close file:
        fclose(fid);
        
        % Get epoch indices:
        mjd = str2double(cellstr(eop_data{5}));
        mjd_ind = (mjd >= mjd_min) & (mjd <= mjd_max);
        
        % Check, if EOP data is available for the observation epochs:
        if sum(mjd >= mjd_max) == 0
            error('No EOP data available for observation epochs (+-5 days for interpolation)! EOP file: %s', eop_file_str);
        end
        
        % Prepare data vectors:
        mjd = mjd(mjd_ind);
        tmp_cellstr = cellstr(eop_data{9});
        xp_arcsec = str2double(tmp_cellstr(mjd_ind));
        xp_arcsec(isnan(xp_arcsec)) = 0;
        xp_mas = xp_arcsec * 1000;
        
        tmp_cellstr = cellstr(eop_data{12});
        yp_arcsec = str2double(tmp_cellstr);
        yp_arcsec = yp_arcsec(mjd_ind);
        yp_arcsec(isnan(yp_arcsec)) = 0;
        yp_mas = yp_arcsec * 1000;
        
        tmp_cellstr = cellstr(eop_data{16});
        dut1_sec = str2double(tmp_cellstr);
        dut1_sec = dut1_sec(mjd_ind); 
        dut1_sec(isnan(dut1_sec)) = 0;
        dut1_msec = dut1_sec * 1000;
        
        tmp_cellstr = cellstr(eop_data{24});
        dX_mas = str2double(tmp_cellstr);
        dX_mas = dX_mas(mjd_ind);
        dX_mas(isnan(dX_mas)) = 0;
        
        tmp_cellstr = cellstr(eop_data{27});
        dY_mas = str2double(tmp_cellstr);
        dY_mas = dY_mas(mjd_ind); 
        dY_mas(isnan(dY_mas)) = 0;
        
        % Unit conversions:
        xp_rad = xp_mas * mas2rad_const;
        yp_rad = yp_mas * mas2rad_const;
        dX_rad = dX_mas * mas2rad_const;
        dY_rad = dY_mas * mas2rad_const;
        dut1_sec = dut1_msec / 1000;

        
    case {'finals_vievs'}
        % Load EOP file:
        dat  = load(eop_file_str,'r');

        % Get epoch indices:
        mjd  =         dat(:,1) ;
        mjd_ind = (mjd >= mjd_min) & (mjd <= mjd_max);
        
        % Check, if EOP data is available for the observation epochs:
        if sum(mjd >= mjd_max) == 0
            error('No EOP data available for observation epochs (+-5 days for interpolation)! EOP file: %s', eop_file_str);
        end

        % Apply mjd indices:
        dat = dat(mjd_ind, :);
        
        % Prepare data vectors incl. unit conversions:
        mjd         = dat(:,1) ;                   % [d]
        xp_rad      = dat(:,2) * mas2rad_const;    % [rad]
        yp_rad      = dat(:,3) * mas2rad_const;    % [rad]
        dut1_sec    = dat(:,4)/1000 ;              % [sec]
        dX_rad      = dat(:,5) * mas2rad_const;   % [rad]
        dY_rad      = dat(:,6) * mas2rad_const;   % [rad]

	case {'eop_txt_file_vievs'}
                
        % Load EOP file:
        dat  = load(eop_file_str,'r');
        
        index1 = dat(:,1)<=floor(MJD(1));
        indFirst = length(dat(index1,1))-5;
    
        index2 = dat(:,1)<=ceil(MJD(end));
        indLast = length(dat(index2,1))+5;

        dat=dat(indFirst:indLast,:);
        mjd  =              dat(:,1);   % [d]
        xp_rad   = mas2rad(dat(:,2));   % [rad]
        yp_rad   = mas2rad(dat(:,3));   % [rad]
        dut1_sec =    dat(:,4)/1000 ;   % [sec]
        dX_rad   = mas2rad(dat(:,5));   % [rad]
        dY_rad   = mas2rad(dat(:,6));   % [rad]
end

% check for leap second within interpolation time span
leap = tai_utc(mjd);
jump = find(diff(leap) ~= 0);
if ~isempty(jump)
    fprintf(1, 'Interpolation period of dUT1 includes a leap second - dUT1 values are corrected.\n')
    leap = mjd(jump+1) - mjd(jump);
    if jump < 6
       dut1_sec(1:jump) = dut1_sec(1:jump) + leap; 
    else
       dut1_sec(jump+1:end) = dut1_sec(jump+1:end) - leap;
    end
end

