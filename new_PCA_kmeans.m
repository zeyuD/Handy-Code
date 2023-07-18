X = cat(1, k0, k1, k2, k3, k4, k5, k6, k7, k8, k9);

% Apply PCA and keep the first three principal components
[coeff,score,latent] = pca(X);
X_reduced = score(:,1:3);
x_normed = normalize(X_reduced,'range');

% Define the number of clusters
k = 10;

% Perform k-means clustering
[cluster_idx, cluster_centroid] = kmeans(X_reduced, k);

% cluster_idx contains the cluster indices for each data point in X
% cluster_centroid contains the centroid coordinates for each cluster

% For 3-D data
figure('Position',[100,100,700,550]);
hold on;

colors = ["#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE", "#A2142F", "#7F7F7F", "#0F6FFF", "#4DFF00", "#FF00F6"]; % Define colors for each cluster
markers = ['*', '+', 'x', '>', 's', "pentagram", '<', '^', "diamond", "hexagram"];
legends = cell(1, k); % Initialize cell array for legends

% Plot each cluster with different color and create legend
for i = 1:k
    scatter3(x_normed(cluster_idx==i,1), x_normed(cluster_idx==i,2), x_normed(cluster_idx==i,3), 'Marker', markers(i), 'MarkerFaceColor', colors(i), "MarkerEdgeColor", colors(i), 'SizeData',50);
%     legends{i} = sprintf('Cluster %d', i);
    legends{i} = sprintf(num2str(i-1));
end

% % Plot cluster centroids and create legend
% scatter3(cluster_centroid(:,1), cluster_centroid(:,2), cluster_centroid(:,3), 'Marker', 'x', 'MarkerEdgeColor', 'k', 'LineWidth', 3)
% legends{k+1} = 'Cluster Centroids';

hold off;

% Add labels
xlabel('PC 1')
xticks(0:0.2:1);
ylabel('PC 2')
zlabel('PC 3')

grid on;
view(345,5);

% Add legend
legend(legends, 'Location', 'best','NumColumns',2);
set(gca,'FontSize', 22, 'FontWeight', 'bold', 'LineWidth', 2);
align_axislabel([], gca)

% % For 2-D data
% figure;
% hold on;
% 
% colors = ["#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE", "#A2142F", "#7F7F7F", "#0F6FFF", "#4DFF00", "#FF00F6"]; % Define colors for each cluster
% legends = cell(1, k); % Initialize cell array for legends
% 
% % Plot each cluster with different color and create legend
% for i = 1:k
%     scatter(X_reduced(cluster_idx==i,1), X_reduced(cluster_idx==i,2), 36, 'MarkerFaceColor', colors(i), "MarkerEdgeColor", colors(i));
%     legends{i} = sprintf('Cluster %d', i);
% end
% 
% hold off;
% 
% % Add labels
% xlabel('First Principal Component')
% ylabel('Second Principal Component')
% 
% % Add legend
% % legend(legends, 'Location', 'best');
% set(gca,'FontSize', 16, 'FontWeight', 'bold', 'LineWidth', 1);

