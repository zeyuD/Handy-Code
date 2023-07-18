clc;
clear;
device = 'lg';
num_ins = 20;
img_size = 150;
ins_len = 45;
fs = 30;
win_size = 15;
ov = 14;

labels = ["0","1","2","3","4","5","6","7","8","9"];

for l = 1:length(labels)
    label = labels(l);
    for ins = 1:num_ins
        fprintf("Drawing key %s, instance %i. \n", label, ins);
        if strcmp(device,'lg') & strcmp(label,'1')
            frame_flow_x_time = load("artifacts/"+device+"_"+label+"_x_time_"+num2str(ins)+".mat").x_time(11:11+ins_len,:,:);
            frame_flow_y_time = load("artifacts/"+device+"_"+label+"_y_time_"+num2str(ins)+".mat").y_time(11:11+ins_len,:,:);
        else
            frame_flow_x_time = load("artifacts/"+device+"_"+label+"_x_time_"+num2str(ins)+".mat").x_time(1:ins_len,:,:);
            frame_flow_y_time = load("artifacts/"+device+"_"+label+"_y_time_"+num2str(ins)+".mat").y_time(1:ins_len,:,:);
        end
        avg_x = mean(frame_flow_x_time,[2 3]);
        avg_y = mean(frame_flow_y_time,[2 3]);
        % min_a = min(min(avg_x),min(avg_y));
        % max_a = max(max(abs(avg_x)),max(abs(avg_y)));
        avg_x = avg_x/max(abs(avg_x));
        avg_y = avg_y/max(abs(avg_y));
        
        t = tiledlayout(1,1,'Padding','none');
        t.Units = 'pixels';
        t.OuterPosition = [0 0 img_size img_size];
        nexttile;
        % figure('Position',[150,150,100,100]);
        spectrogram(avg_x, hann(win_size), ov, [], fs, 'yaxis');
        colormap jet;
        axis off;
        colorbar off;
        exportgraphics(gcf,'lg/spec_x/k'+label+'x_'+num2str(ins)+'.png','BackgroundColor','white');
        close;

        t = tiledlayout(1,1,'Padding','none');
        t.Units = 'pixels';
        t.OuterPosition = [0 0 img_size img_size];
        nexttile;
        % figure('Position',[150,150,100,100]);
        spectrogram(smooth(avg_y), hann(win_size), ov, [], fs, 'yaxis');
        % set(gcf, 'color','none');
        % set(gca, 'color','none');
        colormap jet;
        axis off;
        colorbar off;
        exportgraphics(gcf,'lg/spec_y/k'+label+'y_'+num2str(ins)+'.png','BackgroundColor','white');
        close;
    end
end

