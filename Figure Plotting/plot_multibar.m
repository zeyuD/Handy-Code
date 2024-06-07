y = [1 1; 0.85 0.52; 0.9 0.66];

x = categorical({'Our Interface', 'Float Virtual Keypad', 'On Table [66]'});
x = reordercats(x,{'Our Interface', 'Float Virtual Keypad', 'On Table [66]'});
hB = bar(x,y,'BarWidth',0.8);

% hB.FaceColor = 'flat';
% hB.CData(1,:) = [0.7 0.7 0.7];
% hB.CData(2,:) = [0.7 0.7 0.7];
% hB.CData(3,:) = [0.7 0.7 0.7];
% hB.CData(4,:) = [0.7 0.7 0.7];
% hB.CData(5,:) = [0.7 0.7 0.7];
% hB.CData(6,:) = [0.7 0.7 0.7];
% % hB.CData(12,:) = [0.9 0.9 0.9];

barColors = ["#e6e6e6", "#b3b3b3"]; 
children = get(gca, 'Children');
for i = 1:length(children)
    set(children(i), 'FaceColor', barColors(i));
end

% xlabel('Users');
ylabel('Accuracy');
% labels = {'79.62' '90.00' '59.62' '52.69' '75.00' '52.69'};

xtips1 = hB(1).XEndPoints;
ytips1 = hB(1).YEndPoints;
xtips2 = hB(2).XEndPoints;
ytips2 = hB(2).YEndPoints;
% xtips3 = hB(3).XEndPoints;
% ytips3 = hB(3).YEndPoints;
labels1 = string(hB(1).YData);
labels2 = string(hB(2).YData);
% labels3 = string(hB(3).YData);
text_size = 20;
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',text_size,'FontWeight','bold')
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','FontSize',text_size,'FontWeight','bold')
% text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom','FontSize',text_size,'FontWeight','bold')

% xt = get(gca, 'XTick');
% text(xt, y, labels, 'HorizontalAlignment','center','VerticalAlignment','bottom','FontSize',16,'FontWeight','bold')

% Rotate X-axis labels
xticks = get(gca, 'XTick');
xticklabels = get(gca, 'XTickLabel');
set(gca, 'XTickLabel', []);
for i = 1:length(xticks)
    text(xticks(i), -0.05, xticklabels(i, :),'FontSize', 15.5, 'FontWeight', 'bold', 'HorizontalAlignment', 'center', 'Rotation', 0);
end

% yticks(0.5:0.05:1);
ylim([0 1]);
set(gca,'FontSize', text_size, 'FontWeight', 'bold', 'XTickLabelRotation',0);
set(gcf,'Position',[100 100 680 460]);
legend("Key Recognition Rate","PIN Recognition Rate","Location","best");
