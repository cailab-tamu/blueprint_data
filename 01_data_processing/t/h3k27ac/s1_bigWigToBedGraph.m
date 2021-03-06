load ../../mart_export_GRCh37_p13_coding_genes
filelistwig;

n=10000;

%%

for idx=1:length(T.Genename)
idx
if exist(sprintf('res_wig/%s.mat',T.Genename{idx}),'file'), continue; end


gchrid=T.Chromosomescaffoldname(idx);
gstrand=T.Strand(idx);

if gstrand==1
gstart=double(T.GeneStartbp(idx));
else
gstart=double(T.GeneEndbp(idx));   
end

D=zeros(length(bigwigfiles),2*n+1,1);
offset=gstart-n-1;
try
    for k=1:length(bigwigfiles)
    fname=bigwigfiles{k};
    txt=sprintf('bigWigToBedGraph -chrom=chr%d -start=%d -end=%d download_files/%s tmp1/%d.txt',...
        gchrid,gstart-10000,gstart+10000,fname,k);
    status=system(txt);
    if status==0
        d=zeros(1,size(D,2));
        [a,b,c]=importfile(sprintf('tmp1/%d.txt',k));
        a=a-offset;
        b=b-offset;
        for kk=1:length(a)
            d(a(kk):b(kk))=c(kk);
        end
        D(k,:)=d;
    end
    end
catch
    disp([':(.......',T.Genename{idx}]);
end
save(sprintf('res_wig/%s',T.Genename{idx}),'D');
end



function [VarName2,VarName3,VarName4] = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [VARNAME2,VARNAME3,VARNAME4] = IMPORTFILE(FILENAME) Reads data from
%   text file FILENAME for the default selection.
%
%   [VARNAME2,VARNAME3,VARNAME4] = IMPORTFILE(FILENAME, STARTROW, ENDROW)
%   Reads data from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   [VarName2,VarName3,VarName4] = importfile('11.txt',1, 1674);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2016/12/22 11:55:16

%% Initialize variables.
delimiter = '\t';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

%% Format for each line of text:
%   column2: double (%f)
%	column3: double (%f)
%   column4: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
VarName2 = dataArray{:, 1};
VarName3 = dataArray{:, 2};
VarName4 = dataArray{:, 3};
end


