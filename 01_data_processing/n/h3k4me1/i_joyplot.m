function i_joyplot(D)
figure;
hold on
D=D./max(D(:));
[n,p]=size(D);

for k=1:n
   plot(1.05*k*ones(1,p)+D(k,:),'k-');
end
xlim([1 p]);
set(gca, 'YTick', []);
return;

figure;
for k=1:n
    subplot_tight(n, 1, k, 0);    
    bar(D(k,:),1);
    xlim([1 p]);
    ylim([0 1]);
    set(gca, 'XTick', []);
    set(gca, 'YTick', []);
end
