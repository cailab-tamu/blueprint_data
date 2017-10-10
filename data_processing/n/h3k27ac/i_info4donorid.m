function [donorinfo]=i_info4donorid(donorid)
	
    %load \\a361-1\DISK4T\Blueprint2\sampleinfo_r\sample_covariate_info
    load ../../sampleinfo_r/sample_covariate_info
    [y,idx]=ismember(donorid,Tsampleinfo.DonorID);
    if any(~y) 
        donorinfo=[];
        donorid(~y)
    else
        donorinfo=Tsampleinfo(idx,:);
    end
    
    
