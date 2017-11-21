addpath('/home/cailab/GitHub/PGEToolbox');
celltype='n';
marktype='me';
vstep=100;
usematfile=false;


if usematfile
    matobj=matfile(sprintf('sclk_%s_%s_100bp.mat',marktype,celltype));
    [nrows,ncols]=size(matobj,'sclk');
else
    load(sprintf('sclk_%s_%s_100bp.mat',marktype,celltype));
    [nrows,ncols]=size(sclk);
end

for smpid=56:ncols
    tic
    mkdir(sprintf('mat_wig_%s_%s/individual_wig_norm/%d',...
          celltype,marktype,smpid));
    
    c=1;   
    for chrid=1:22
        fprintf('%s...%s...%s...%d...%d...chr%d\n',...
                mfilename,celltype,marktype,smpid,ncols,chrid);
        L=chrlen(chrid);
        vst=1:vstep:L;
	    vnd=vstep:vstep:L;
        if length(vst)>length(vnd)
                vst=vst(1:end-1);
        end
        
        load(sprintf('mat_wig_%s_%s/individual_wig/%d/%d',...
              celltype,marktype,smpid,chrid),'data');
         
        for k=1:length(vst)
	        % if matobj.sclk(c,smpid)~=1
            if sclk(c,smpid)~=1
               data(vst(k):vnd(k))=data(vst(k):vnd(k))*sclk(c,smpid);
            end
            c=c+1;
        end

	data=single(data);
        save(sprintf('mat_wig_%s_%s/individual_wig_norm/%d/%d',...
              celltype,marktype,smpid,chrid),'data','-v7.3');
    end
    toc
end

