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
%%
for i = 22 : 42
    filename{i} = strcat('D:\Haustorium\Secondary Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
    I0{i} = rgb2gray(prev{i});
end
for i = 22 : 42
    B{i} = imgaussfilt(I0{i});
    I{i} = adapthisteq(B{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 22 : 42
    Ia{i} = double(I{i});
    sigmar = 40;
    eps    = 1e-3;
    sigmas = 3;
    [g,Ng] = GPA(Ia{i}, sigmar, sigmas, eps, 'Gauss'); 
    g1=uint8(g);
    result{i} = g/255;
end
%%
for i = 43 : 63
    filename{i} = strcat('D:\Haustorium\Final Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
    I0{i} = rgb2gray(prev{i});
end
for i = 43 : 63
    B{i} = imgaussfilt(I0{i});
    I{i} = adapthisteq(B{i},'clipLimit',0.02,'Distribution','rayleigh');
end
for i = 43 : 63
    Ia{i} = double(I{i});
    sigmar = 40;
    eps    = 1e-3;
    sigmas = 3;
    [g,Ng] = GPA(Ia{i}, sigmar, sigmas, eps, 'Gauss'); 
    g1=uint8(g);
    result{i} = g/255;
end
%%
processed = zeros(786432,63);

for i = 1 : 63
    processed(:,i) = reshape(result{1,i}',786432,1);
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