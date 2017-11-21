addpath('~/GitHub/PGEToolbox/');
addpath('~/GitHub/MBEToolbox/');

celltype='m';

% dirtxt='/mnt/DISK4T/Blueprint2/Cell_T/H3K27ac';
% dirtxt='/media/cailab/DISK4T/DATA/Blueprint2/Cell_M/H3K27ac';

dirtxt=sprintf('/mnt/DISK4T/Blueprint2/Cell_%s/H3K4me1',upper(celltype));


load(sprintf('%s/metadata_%s_me1.mat',dirtxt,upper(celltype)));

%%
for kk=1:length(bigwigfiles)
    fprintf('%d......%d\n',kk,length(bigwigfiles));

targetfolder=sprintf('mat_wig_%s_me/%d',celltype,kk);
if exist(targetfolder,'dir')
    disp(['skip ',targetfolder]);
    continue;
end
tic;
    mkdir(targetfolder);
    infile=sprintf('%s/download_files/%s',...
                  dirtxt,bigwigfiles{kk});

    for chrid=1:22
        txt=sprintf('bigWigToBedGraph %s -chrom=chr%d -start=1 -end=%d %d_%d.bg',...
                    infile,chrid,chrlen(chrid),kk,chrid);
        [status]=system(txt);
        pause(3);
        if status==0
            % system(sprintf('cut -f2-4 %d_%d.bedGraph >%d_%d.bg',chrid,chrid));
            data=zeros(chrlen(chrid),1,'single');
            fid=fopen(sprintf('%d_%d.bg',kk,chrid),'r');
            D=textscan(fid,'%s%d%d%f');
            fclose(fid);
            for k=1:length(D{2})
                data(D{2}(k):D{3}(k))=single(D{4}(k));
            end
            save(sprintf('%s/%d',targetfolder,chrid),'data','-v7.3');
            pause(3);
            system(sprintf('rm %d_%d.bg',kk,chrid));
            clear data
        end
    end
toc; 
end
