function d = MeanSqrDist(im1,im2)
    im1 = uint8(im1);
    im2 = uint8(im2);
%%the function calculte the mean square betwenn two images
%%calculte per pixel then add all and divid by the namber of pixels in the
%%image
    d = sum((im1-im2).^2,'all')/(size(im1,1)*size(im1,2));
    %%return the mean sqr
end