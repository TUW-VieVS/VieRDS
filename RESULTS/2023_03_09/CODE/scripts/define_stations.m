function [stat] = define_stations(session_label)
if strcmp(session_label,'VO1021')
    stat.c8={'ONSA13NE','RAEGYEB','GGAO12M','WETTZ13S','ISHIOKA','WESTFORD','KOKEE12M','MACGO12M'};
    stat.c2={'OE','YJ','GS','WS','IS','WF','K2','MG'};
end

if contains(session_label,'mcs')
    stat.c8={'WETTZELL','YEBES12M'};
    stat.c2={'S1','S2'};
end

if contains(session_label,'VGOSM')
    stat.c8={'WETTZELL','YEBES12M'};
    stat.c2={'S1','S2'};
end

end

