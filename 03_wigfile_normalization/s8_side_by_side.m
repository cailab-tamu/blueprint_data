celltype='n';
chrid=17;
n=10;

figure;
for k=1:n
    load(sprintf('mat_wig_%s_ac/individual_wig/%d/%d.mat',...
         celltype,k,chrid));
    subplot(n,2,k*2-1)
    plotx(data);  
    
    load(sprintf('mat_wig_%s_ac/individual_wig_norm/%d/%d.mat',...
         celltype,k,chrid));
    subplot(n,2,k*2)
    plotx(data);
end

function plotx(d)
x=d(1:1000:end);
stem(x,'marker','none','color','k');
set(gca,'XTickLabel',[])
  ylim([0 200])
  xlim([1 length(x)])
end
