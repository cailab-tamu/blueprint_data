addpath('/home/cailab/GitHub/PGEToolbox');
celltype='n';
marktype='me';

vstep=100;


dirtxt=sprintf('/mnt/DISK4T/Blueprint2/Cell_%s/H3K4me1',upper(celltype));
load(sprintf('%s/metadata_%s_me1.mat',dirtxt,upper(celltype)));
smpnum=length(bigwigfiles);


SmpBinTot=[];


for smpid=1:smpnum

    SmpBinVal=[];
    c=1;
	tic
    for chrid=1:22
        fprintf('%s...%s...%s...%d...%d...chr%d\n',...
                 mfilename,celltype,marktype,smpid,smpnum,chrid);
        L=chrlen(chrid);
        vst=1:vstep:L;
	    vnd=vstep:vstep:L;
	if length(vst)>length(vnd)
        	vst=vst(1:end-1);
	end

        smpbin=zeros(length(vst),1,'single');
        load(sprintf('mat_wig_%s_%s/individual_wig/%d/%d',...
              celltype,marktype,smpid,chrid),'data');
        parfor k=1:length(vst)
                smpbin(k)=single(mean(data(vst(k):vnd(k))));

        end
        SmpBinVal=[SmpBinVal; smpbin];
    end
	toc
    SmpBinTot=[SmpBinTot SmpBinVal];

if smpid>130
	[~,out]=system('vmstat -s -S M | grep "free memory"');
        mem=sscanf(out,'%f  free memory');
	if mem<50  % 50M
		disp('paused...');
		pause;
	end
end

end


sclk=quantilenorm(SmpBinTot);
sclk=single(sclk./SmpBinTot);
sclk(isnan(sclk)|isinf(sclk))=1;

save(sprintf('sclk_%s_%s_100bp.mat',marktype,celltype),'sclk','-v7.3');



