function [T] = create_ampl_table(ST,out_X,out_Y)

Nst=length(ST);
T=table;

for i=1:Nst
    
    stat=ST{i};
    
    Xavg = out_X(i).avg*1000;
    Yavg = out_Y(i).avg*1000;
    Xstd = out_X(i).std*1000;
    Ystd = out_Y(i).std*1000;
   
    [AX,BX,CX,DX] = calc_band_mean(Xavg);
    [AY,BY,CY,DY] = calc_band_mean(Yavg);
    
    [aX,bX,cX,dX] = calc_band_mean(Xstd);
    [aY,bY,cY,dY] = calc_band_mean(Ystd);   
    
    
    T.AX(i) = AX;    
    T.aX(i) = aX;    
    T.AY(i) = AY;    
    T.aY(i) = aY;      
    
    T.BX(i) = BX;    
    T.bX(i) = bX;    
    T.BY(i) = BY;    
    T.bY(i) = bY;     
    
    T.CX(i) = CX;    
    T.cX(i) = cX;    
    T.CY(i) = CY;    
    T.cY(i) = cY;
    
    T.DX(i) = DX;    
    T.dX(i) = dX;    
    T.DY(i) = DY;    
    T.dY(i) = dY;
    
end

end

