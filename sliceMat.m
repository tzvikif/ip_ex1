function SL = sliceMat(im)
%%the function create a slice matix of the image
%%SL is a matrix of the size 256 (grey scale) * the image as a vector  
    SL = zeros(size(im,1)*size(im,2),256);
    im = im(:);
    %%running on grey scale and adding 1 if the pixel is in the color i
    for i=0:255
        col = (im==i);
        SL(:,i+1) = col;
    end
    %%return value is a slice matrix of im
end