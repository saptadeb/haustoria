%%
for i = 1 : 21
    filename{i} = strcat('D:\Haustorium\Primary Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
end
for i = 1 : 21
    I{i} = rgb2gray(prev{i});
end
for i = 1 : 21
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 1 : 21
   I{i} = double(I{i})/255;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end
%%
for i = 22 : 42
    filename{i} = strcat('D:\Haustorium\Secondary Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
end
for i = 22 : 42
    I{i} = rgb2gray(prev{i});
end
for i = 22 : 42
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 22 : 42
   I{i} = double(I{i})/255;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end
%%
for i = 43 : 63
    filename{i} = strcat('D:\Haustorium\Final Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
end
for i = 43 : 63
    I{i} = rgb2gray(prev{i});
end
for i = 43 : 63
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 43 : 63
   I{i} = double(I{i})/255;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end
processed = zeros(4096,63);
%%
for i = 1 : 63
    processed(:,i) = reshape(result{1,i}',4096,1);
end
%%
target = zeros(3,63);
for i = 1 : 21
    target(1,i) = 1;
end
for i = 22 : 42
    target(2,i) = 1;
end
for i = 43 : 63
    target(3,i) = 1;
end