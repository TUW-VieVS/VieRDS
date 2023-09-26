function print_yaml_files(yaml_content,namestring,splitting_mode)
%PRINT_YAML_FILES prints yaml files according to selected splitting mode
%   splitting_mode ... for simulation of VGOS sessions:
%       none ... each observation corresponds to 1 yaml file
%       bands ... each observation corresponds to 4 yaml files with 1 band
%       (8 channels) each
%       channels ... each observation corresponds to 32 yaml files with 1
%       channel each
channels = ["3032.40","3064.40","3096.40","3224.40","3320.40","3384.40","3448.40","3480.40",...
            "5272.40","5304.40","5336.40","5464.40","5560.40","5624.40","5688.40","5720.40",...
            "6392.40","6424.40","6456.40","6584.40","6680.40","6744.40","6808.40","6840.40",...
            "10232.40","10264.40","10296.40","10424.40","10520.40","10584.40","10648.40","10680.40"];
% define channels used by VGOS
if splitting_mode == "none"
    frequencies = strjoin(channels,",");
    yaml_content = insertAfter(yaml_content,"f0: ","["+frequencies+"]");
    filename = "input_val_"+namestring+".yaml";
    fileID = fopen(filename,"w");
    fwrite(fileID,yaml_content);
    fclose(fileID);
end
if splitting_mode == "bands"
    bands = ["A","B","C","D"];
    for nBand = 1:4
        frequencies = strjoin(channels(1+8*(nBand-1):nBand*8),",");
        yaml_content2 = insertAfter(yaml_content,"f0: ","["+frequencies+"]");
        filename = "input_val_"+namestring+"_band"+bands(nBand)+".yaml";
        fileID = fopen(filename,"w");
        fwrite(fileID,yaml_content2);
        fclose(fileID);
    end
end
if splitting_mode == "channels"
    for nCh = 1:32
        yaml_content2 = insertAfter(yaml_content,"f0: ",+channels(nCh));
        filename = "input_val_"+namestring+"_channel"+nCh+".yaml";
        fileID = fopen(filename,"w");
        fwrite(fileID,yaml_content2);
        fclose(fileID);
    end
end
end