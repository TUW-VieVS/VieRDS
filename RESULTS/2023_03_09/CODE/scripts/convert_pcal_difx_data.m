function [X,Y] = convert_pcal_difx_data(s)

ft=s(1).f;
pt=s(1).p;

idelete=find(ft==-1e6);
ft(idelete)=[];
pt(idelete)=[];

[ft_unique,~]=unique(ft);

X=struct;
Y=struct;

for i=1:length(s)
    for j=1:length(s(1).f)
        fi=s(i).f(j);
        ift=find(ft_unique==fi);
        if isempty(ift)
            continue;
        end
        
        pol=s(i).p(j);
                
        if strcmp(pol,'X')
% %             ch_X(ift).ampl(i)=abs(s(i).d(j));
% %             ch_X(ift).phas(i)=angle(s(i).d(j));
            if fi==3420e6
                disp('puase')
            end
            X(ift).C(i)=s(i).d(j);
            X(ift).f(i)=fi;
            X(ift).mjd(i)=s(i).mjd;
            X(ift).scan_id(i)=s(i).scan_id;
        end
        if strcmp(pol,'Y')
%             ch_Y(ift).ampl(i)=abs(s(i).d(j));
%             ch_Y(ift).phas(i)=angle(s(i).d(j));
            Y(ift).C(i)=s(i).d(j);
            Y(ift).f(i)=fi;
            Y(ift).mjd(i)=s(i).mjd;
            Y(ift).scan_id(i)=s(i).scan_id;
        end
    end
end


end

