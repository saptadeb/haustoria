for i = 1 : 21
    filename{i} = strcat('D:\Haustorium\Primary Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
    I0{i} = rgb2gray(prev{i});
end
for i = 1 : 21
    B{i} = imgaussfilt(I0{i});
    I{i} = adapthisteq(B{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 1 : 21
    Ia{i} = double(I{i});
    sigmar = 40;
    eps    = 1e-3;
    sigmas = 3;
    [g,Ng] = GPA(Ia{i}, sigmar, sigmas, eps, 'Gauss'); 
    g1=uint8(g);
    result{i} = g/255;
end

i=20;
figure;
subplot(2,2,1);
imshow(prev{i});
title('colour');
subplot(2,2,2);
imshow(I0{i});
title('BW');
subplot(2,2,3);
imshow(I{i});
title('CLAHE');
subplot(2,2,4);
imshow(result{i});
title('BFT');

% figure;
% subplot(1,4,1);
% imhist(I0{i});
% title('BW');
% subplot(1,4,2);
% imhist(B{i});
% title('Gauss');
% subplot(1,4,3);
% imhist(I{i});
% title('CLAHE');
% subplot(1,4,4);
% imhist(result{i});
% title('BFT');