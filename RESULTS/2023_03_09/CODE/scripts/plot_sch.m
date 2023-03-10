function [id,out] = plot_sch(sdata,stations,freq,pol,ch,datatype,ptype,my_colors)


df = [1,diff(freq.f0)];

Nst=length(stations);

if ~iscell(stations)
    stations={stations};
    Nst=1;
end

if Nst>1
    figure; hold on;
end

for jst=1:Nst
    
    station=stations{jst};
    Ndata=length(sdata);
    
    
    %% get row id
    ist=zeros(Ndata,1);
    id=zeros(Ndata,1);
    idbl=zeros(Ndata,1);
    a=[];
    ibl=0;
    for i=1:Ndata
        a=strfind(sdata(i).baseline,station);

        if a > 0
            ist(i)=1;
        end
        if isempty(a)
            ist(i)=0;
        end
        
        if a==1
            ibl=1;
        end
        if a>1
            ibl=2;
        end
        if a<1
            ibl=0;
        end
        if isempty(a)
            ibl=0;
        end
        
        if ibl~=0
            if strcmp(sdata(i).pol_label(ibl),pol)
                id(i)=1;
            else
                id(i)=0;
            end
            idbl(i)=ibl;
        end
    end
    
    %% create data matrix for colorbar plot
    
    if strcmp(ptype,'time')
        Ndata=sum(id);
        idf=find(id);
        D=[];
        X=[];
        C=[];
        for i=1:Ndata
            j=idf(i);
            if idbl(j)==1
                dstr=[datatype,'_ref'];
            end
            if idbl(j)==2
                dstr=[datatype,'_rem'];
            end
            d=sdata(j).(dstr);
            d=d(ch);
            D=[D,d];
            %             x=Tdata.datenum(j)*ones(1,length(d));
            x=[];
            for idatetime=1:length(d)
                x=[x,sdata(j).datetime];
            end
            %             x=Tdata.datetime(j)*ones(1,length(d));
            
            %     x=Tdata.hhmmss_start(j)*ones(1,length(d));
            X=[X,x];
            c=ch;
            C=[C,c];
        end
        
        if Nst==1
            figure;
        end
        scatter(X,D,[],C,'.');
        colorbar
        title(sprintf('%s,%s,%s',datatype,station,pol))
        yl1=yline(0.011,'-',{''},'LineWidth',2);
        yl1.LabelHorizontalAlignment = 'left';
        yl1.LabelVerticalAlignment = 'top';
        
        yl1=yline(0.0343,'-',{sprintf('sweet area \n(0.011 - 0.034)')},'LineWidth',2);
        yl1.LabelHorizontalAlignment = 'left';
        yl1.LabelVerticalAlignment = 'bottom';
        
        grid on
        
        %         xlabel('datenum')
        ylabel('pcal amplitude')
        
        xtickformat('dd-MMM-HH:mm')
        xtickangle(45)
        
        ylim([0.002,0.5])
        set(gca, 'YScale', 'log')
        set(gca,'FontSize',15);
        
        
    end
    
    if strcmp(ptype,'delta-phase time')
        Ndata=sum(id);
        idf=find(id);
        D=[];
        X=[];
        C=[];
        for i=1:Ndata
            j=idf(i);
            if idbl(j)==1
                dstr=[datatype,'_ref'];
            end
            if idbl(j)==2
                dstr=[datatype,'_rem'];
            end
            d=sdata(j).(dstr);
            d=d(ch);
            d=diff(d);
            d=[0,d];
            %             if max(ch)==8
            %                 d=d(1:8)-d(1);
            %             end
            %             if max(ch)==16
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %             end
            %             if max(ch)==24
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %                 d(17:24)=d(17:24)-d(17);
            %             end
            %             if max(ch)==32
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %                 d(17:24)=d(17:24)-d(17);
            %                 d(25:32)=d(25:32)-d(25);
            %             end
            
            D=[D,d];
            x=[];
            for idatetime=1:length(d)
                x=[x,sdata(j).datetime];
            end
            X=[X,x];
            c=ch;
            C=[C,c];
        end
        
        if Nst==1
            figure;
        end
        
        for kch=1:max(ch)
            if kch==1 || kch==9 || kch==17 || kch==25
                D(C==kch)=zeros(1,length(D(C==kch)));
            end
            D(C==kch)=rad2deg(unwrap(deg2rad(D(C==kch))));
%             D(C==kch)=unwrap(deg2rad(D(C==kch)))/(2*pi*df(kch));
        end
        scatter(X,D,[],C,'.');
        colorbar
        title(sprintf('%s,%s,%s',datatype,station,pol))
        grid on
        ylabel('relative phase')
        xtickformat('dd-MMM-HH:mm')
        xtickangle(45)
        set(gca,'FontSize',15);
        
    end
    
    if strcmp(ptype,'freq - channel average')
        Ndata=sum(id);
        idf=find(id);
        D=[];
        X=[];
        C=[];
        d=[];
        for i=1:Ndata
            j=idf(i);
            if idbl(j)==1
                dstr=[datatype,'_ref'];
                d=sdata(j).(dstr);
                d=d(ch);
            end
            if idbl(j)==2
                dstr=[datatype,'_rem'];
                d=sdata(j).(dstr);
                d=d(ch);
            end
            D=[D,d];
            x=sdata(j).datenum*ones(1,length(d));
            %     x=Tdata.hhmmss_start(j)*ones(1,length(d));
            X=[X,x];
            c=ch;
            C=[C,c];
        end
        
        avg = zeros(1,length(ch));
        std = zeros(1,length(ch));
        for i=ch
            j=C==i;
            avg(i)=mean(D(j));
            std(i)=sqrt(var(D(j)));
        end
        
        if Nst==1
            figure;
            title(sprintf('%s,%s,%s',datatype,station,pol))
        end
        errorbar(ch,avg,std,'LineWidth',1.5,'Color',my_colors(jst,:))
        
        %         yl1.LabelVerticalAlignment = 'top';
        
        if jst==1
            
            xl1=xline(8,'--',{'band A'},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'left';
            xl1.LabelVerticalAlignment = 'top';
            
            xl1=xline(1,'--',{''},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'right';
            xl1.LabelVerticalAlignment = 'middle';
            
            
            xl1=xline(15,'--',{'band B'},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'left';
            xl1.LabelVerticalAlignment = 'top';
            
            xl1=xline(9,'--',{''},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'right';
            xl1.LabelVerticalAlignment = 'middle';
            
            xl1=xline(23,'--',{'band C'},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'left';
            xl1.LabelVerticalAlignment = 'top';
            
            xl1=xline(16,'--',{''},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'right';
            xl1.LabelVerticalAlignment = 'middle';
            
            xl1=xline(32,'--',{'band D'},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'left';
            xl1.LabelVerticalAlignment = 'top';
            
            xl1=xline(24,'--',{''},'LineWidth',1);
            xl1.LabelHorizontalAlignment = 'right';
            xl1.LabelVerticalAlignment = 'middle';
            
            
            yl1=yline(0.011,'-',{''},'LineWidth',2);
            yl1.LabelHorizontalAlignment = 'left';
            yl1.LabelVerticalAlignment = 'top';
            
            yl1=yline(0.0343,'-',{sprintf('sweet area \n(0.011 - 0.034)')},'LineWidth',2);
            yl1.LabelHorizontalAlignment = 'left';
            yl1.LabelVerticalAlignment = 'bottom';
            
            
            xlabel('subband')
            ylabel('pcal amplitude')
        end
        
        out(jst).avg=avg;
        out(jst).std=std;
        
        xlim([1,32])
        ylim([0.002,0.5])
        
        set(gca, 'YScale', 'log')
        
        
        grid on
        xticks([1:1:32])
        xticklabels({'1','','','','','','','','9','','','','','','','','16','','','','','','','','25','','','','','','','32'})
        set(gca,'FontSize',15);
        
    end
    
    if strcmp(ptype,'delta-phase freq channel average')
        Ndata=sum(id);
        idf=find(id);
        D=[];
        X=[];
        C=[];
        for i=1:Ndata
            j=idf(i);
            if idbl(j)==1
                dstr=[datatype,'_ref'];
            end
            if idbl(j)==2
                dstr=[datatype,'_rem'];
            end
            d=sdata(j).(dstr);
            d=d(ch);
            d=diff(d);
            d=[0,d];
            %             if max(ch)==8
            %                 d=d(1:8)-d(1);
            %             end
            %             if max(ch)==16
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %             end
            %             if max(ch)==24
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %                 d(17:24)=d(17:24)-d(17);
            %             end
            %             if max(ch)==32
            %                 d(1:8)=d(1:8)-d(1);
            %                 d(9:16)=d(9:16)-d(9);
            %                 d(17:24)=d(17:24)-d(17);
            %                 d(25:32)=d(25:32)-d(25);
            %             end
            
            D=[D,d];
            x=[];
            for idatetime=1:length(d)
                x=[x,sdata(j).datetime];
            end
            X=[X,x];
            c=ch;
            C=[C,c];
        end
        
        if Nst==1
            figure;
        end
        
        for kch=1:max(ch)
            if kch==1 || kch==9 || kch==17 || kch==25
                D(C==kch)=zeros(1,length(D(C==kch)));
            end
%             D(C==kch)=rad2deg(unwrap(deg2rad(D(C==kch))));
            D(C==kch)=unwrap(deg2rad(D(C==kch)))/(2*pi*df(kch));
        end
        
        avg = zeros(1,length(ch));
        std = zeros(1,length(ch));
        for i=ch
            j=C==i;
            avg(i)=mean(D(j));
            std(i)=sqrt(var(D(j)));
        end
        
        if Nst==1
            figure;
            title(sprintf('%s,%s,%s',datatype,station,pol))
        end
%                 errorbar(ch,abs(avg),std,'LineWidth',1.5,'Color',my_colors(jst,:))
        plot(ch,std*1e12,'-x','Color',my_colors(jst,:))
        out(jst).avg=avg;
        out(jst).std=std;
        xlabel('subband')
        ylabel('differential pcal delay variation (ps)')
        grid on
        xticks([1:1:32])
        xticklabels({'1','','','','','','','','9','','','','','','','','16','','','','','','','','25','','','','','','','32'})
        set(gca,'FontSize',15);
        xlim([1,32])
        set(gca, 'YScale', 'log')
        %         ylim([1,50])
    end
    
    
end

