function custom_confusion_matrix(groundtruth,prediction,classes,fontsize)

if nargin < 4
    fontsize = 16;
end

confusion_matrix = zeros(length(classes),length(classes));

for i = 1:length(classes)
    index = find(groundtruth == classes(i));
    predicted_labels = prediction(index);
    for j = 1:length(classes)
        confusion_matrix(i,j) = sum(predicted_labels == classes(j))/length(index);
    end
end

figure('Position',[10,10,1000,750]);
image(confusion_matrix,'CDataMapping','scaled');
c = flipud(gray);
c = c(floor(size(c,1)*0.1):floor(size(c,1)*0.8),:);
c(1,:) = ones(1,3);
colormap(c);

xticks(1:length(classes));
yticks(1:length(classes));

% xticklabels((classes-1));
% yticklabels((classes-1));

class_labels = ["A","S","D","F","G","H","J","K","L"];
xticklabels(class_labels);
yticklabels(class_labels);

set(gca,'TickLength',[0 0]);

xlabel('Predicted Keystroke');
ylabel('True Keystroke');

precision = 1e-8;

for i = 1:length(classes)
    for j = 1:length(classes)
        num = round(confusion_matrix(i,j),2);
        first_digit = floor(num/1);
        second_digit = (num-first_digit*1)/0.1;
        if abs(second_digit - round(second_digit)) < precision
            second_digit = round(second_digit);
        else
            second_digit = floor(second_digit);
        end
        third_digit = (num-first_digit*1-second_digit*0.1)/0.01;
        if abs(third_digit - round(third_digit)) < precision
            third_digit = round(third_digit);
        else
            third_digit = floor(third_digit);
        end
        
        num_string = strcat(num2str(first_digit),'.',num2str(second_digit),num2str(third_digit));
        if confusion_matrix(i,j) > 0.5
            text(j,i,num_string,'HorizontalAlignment','center','color','white','fontsize',fontsize,'fontweight','bold');
        elseif confusion_matrix(i,j) >= 0
            text(j,i,num_string,'HorizontalAlignment','center','color','black','fontsize',fontsize,'fontweight','bold');
        end
    end
end

set(gca,'FontSize',fontsize,'fontweight','bold');%,'Linewidth',2);