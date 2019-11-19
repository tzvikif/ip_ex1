function [nim, TM] = SLTmap (im1, im2)
%%the function create a tone map from im1 to im2
    SL = sliceMat(im1);
    TM = zeros(1,256);
    Tr = im2(:);
%reshaping the image to vector
    for i = 1:256
        %%running over grey scale and add to the tone map
        %%if the grey appear in the im
        col = SL(:,i);
        s = sum (col);
        if(s~=0)
            icolor = (Tr'*col)/s;
        else
            icolor = 0;
        end
        TM(i) = icolor;
    end
    nim = reshape(SL*TM', size(im1, 1),size(im1, 2));
    %%the return values are the new image and the tone map as a vector
    %%size 256 
end