% img = imread('einstein.jpg');
% [featureVector,hogVisualization] = extractHOGFeatures(img);
% figure;
% imshow(img);
% hold on;
% plot(hogVisualization);


for i = 1 : 21
    filename{i} = strcat('D:\Haustorium\Final Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
    featureVectr = extractHOGFeatures(prev{i});
    f{i} = featureVectr';    
end


% i=14;
% filename = strcat('D:\Haustorium\Final Stage\',num2str(i),'.tif');
% prev = imread(filename);
% new = imresize(rgb2gray(prev),0.5);
% [featureVector] = extractHOGFeatures(new);
% featureVectr = extractHOGFeatures(new);