srcFilesP = dir('D:\Haustorium\Primary Stage\*.tif');  % the folder in which ur images exists
for i = 1 : 21
    filename{i} = strcat('D:\Haustorium\Primary Stage\',srcFilesP(i).name);
    prev{i} = imread(filename{i});
end
for i = 1 : 21
    new{i} = imresize(prev{i}, [64 64]);
    I{i} = rgb2gray(new{i});
end
for i = 1 : 21
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 1 : 21
   I{i} = double(I{i})/255;
   I{i} = I{i}+0.03*randn(size(I{i}));
   I{i}(I{i}<0) = 0; I{i}(I{i}>1) = 1;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end

srcFilesS = dir('D:\Haustorium\Secondary Stage\*.tif');  % the folder in which ur images exists
for i = 22 : 42
    filename{i} = strcat('D:\Haustorium\Secondary Stage\',srcFilesS(i).name);
    prev{i} = imread(filename{i});
end
for i = 22 : 42
    new{i} = imresize(prev{i}, [64 64]);
    I{i} = rgb2gray(new{i});
end
for i = 22 : 42
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 22 : 42
   I{i} = double(I{i})/255;
   I{i} = I{i}+0.03*randn(size(I{i}));
   I{i}(I{i}<0) = 0; I{i}(I{i}>1) = 1;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end

srcFilesF = dir('D:\Haustorium\Final Stage\*.tif');  % the folder in which ur images exists
for i = 43 : 63
    filename{i} = strcat('D:\Haustorium\Final Stage\',srcFilesF(i).name);
    prev{i} = imread(filename{i});
end
for i = 43 : 63
    new{i} = imresize(prev{i}, [64 64]);
    I{i} = rgb2gray(new{i});
end
for i = 43 : 63
    I{i} = adapthisteq(I{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 43 : 63
   I{i} = double(I{i})/255;
   I{i} = I{i}+0.03*randn(size(I{i}));
   I{i}(I{i}<0) = 0; I{i}(I{i}>1) = 1;
   w     = 5;       % bilateral filter half-width
   sigma = [3 0.1]; % bilateral filter standard deviations
   result{i} = bfilter2(I{i},w,sigma,i);
end
processed = zeros(4096,63);

for i = 1 : 63
    processed(:,i) = reshape(result{1,i}',4096,1);
end

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