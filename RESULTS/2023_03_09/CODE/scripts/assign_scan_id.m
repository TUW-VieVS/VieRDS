function [scan_id] = assign_scan_id(t)

% t=[spc.MG.mjd];
a= find(diff(t)>1.1/(24*60*60));
scan_id=zeros(1,length(t));
for i=1:length(a)+1
    if i==1
        id1=1;
    else
        id1=a(i-1)+1;
    end
    if i==length(a)+1
        id2=length(t);
    else
        id2=a(i);
    end
    int=id1:id2;
    scan_id(int)=i*ones(1,length(int));
end

end

