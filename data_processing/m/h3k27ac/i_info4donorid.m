function [donorinfo]=i_info4donorid(donorid)
	if ispc
    load \\a361-1\DISK4T\Blueprint2\sampleinfo_r\sample_covariate_info
    else
        % load /media/cailab/DISK4T/DATA/Blueprint2/sampleinfo_r/sample_covariate_info
	load ../../sampleinfo_r/sample_covariate_info
    end
    [y,idx]=ismember(donorid,Tsampleinfo.DonorID);
    if any(~y) 
        donorinfo=[];
        donorid(~y)
        find(~y)
    else
        donorinfo=Tsampleinfo(idx,:);
    end
    
    
