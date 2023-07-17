input_val = fileread('input_val.yaml');
expr = '[^\n]date_vec: [^\n]*';
[idx1, idx2] = regexp(input_val,expr);
idx1 = idx1+11;
date_vec = input_val(idx1:idx2);
date_vec = str2num(date_vec,Evaluation="restricted");
date_vec = datetime(date_vec,'TimeZone','Z');
fileID = fopen('input_val1.yaml','w');
fwrite(fileID,input_val);
for i = 2:30
    date_vec = date_vec + seconds(1);
    for j = 1:length(idx1)
        input_val(idx1(j)+1:idx2(j)-1) = num2str(datevec(date_vec),'%4d,%d,%2d,%02d,%02d,%02d');
    end
    fileID = fopen("input_val"+i+".yaml",'w');
    fwrite(fileID,input_val);
end

