function [pol] = define_polarization(session_label)
if contains(session_label,'mcs')
    pol.label={'RR'};
    pol.products={'RR'};
end
if contains(session_label,'VGOSM')
    pol.label={'RR'};
    pol.products={'RR'};
end
end

