count=1;
for i = 1 : 176
    filename{i} = strcat('D:\Haustorium\Final Stage\',num2str(i),'.tif');
    prev{i} = imread(filename{i});
    im = imfinfo(filename{i});
    Width{i} = im.Width;
    Height{i} = im.Height;
    if (Width{i} <1024) || (Height{i} <768)
        a{count}=i;
        count=count+1;
    end
end