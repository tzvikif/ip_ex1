function nim = mapImage(im,tm)
%%the function use tone map to map a image im
    nim = reshape(sliceMat(im)*tm',size(im,1),size(im,2));
    %%return velue the new image
end