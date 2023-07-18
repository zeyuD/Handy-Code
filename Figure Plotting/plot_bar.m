y = [72.50 87.50 62.50 70.00 62.50 62.50 75.00 60.00 37.5 62.5 80.00 85.00]; % 4 Keys
% y = [29 15 17 26 30 30 28 25 22 24 13 38]; % 10 Keys

x = categorical({'Ch1\_X', 'Ch2\_X', 'Ch3\_X', 'Ch4\_X', 'Ch1\_Y', 'Ch2\_Y', 'Ch3\_Y', 'Ch4\_Y', 'Avg_X', 'Avg_Y', 'Max', 'Sum'});
x = reordercats(x,{'Ch1\_X', 'Ch2\_X', 'Ch3\_X', 'Ch4\_X', 'Ch1\_Y', 'Ch2\_Y', 'Ch3\_Y', 'Ch4\_Y', 'Avg_X', 'Avg_Y', 'Max', 'Sum'});
hB = bar(x,y,'BarWidth',0.4);

hB.FaceColor = 'flat';
hB.CData(1,:) = [0.7 0.7 0.7];
hB.CData(2,:) = [0.7 0.7 0.7];
hB.CData(3,:) = [0.7 0.7 0.7];
hB.CData(4,:) = [0.7 0.7 0.7];
hB.CData(5,:) = [0.7 0.7 0.7];
hB.CData(6,:) = [0.7 0.7 0.7];
hB.CData(7,:) = [0.7 0.7 0.7];
hB.CData(8,:) = [0.7 0.7 0.7];
hB.CData(9,:) = [0.7 0.7 0.7];
hB.CData(10,:) = [0.7 0.7 0.7];
hB.CData(11,:) = [0.7 0.7 0.7];
hB.CData(12,:) = [0.9 0.9 0.9];

ylabel('Accuracy (%)');
labels = {'72.5', '87.5', '62.5', '70.0', '62.5', '62.5', '75.0', '60.0', '37.5', '62.5', '80.0', '85.0'}; % 4 Keys
% labels = {'29','15','17','26','30','30','28','25','22','24','13','38'}; % 10 Keys
xt = get(gca, 'XTick');
text(xt, y, labels, 'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',16,'FontWeight','bold')

% yticks(0.5:0.05:1);
% ylim([0.5 1]);
set(gca,'FontSize', 16, 'FontWeight', 'bold', 'XTickLabelRotation',0);
set(gcf,'Position',[100 100 600 400]);
