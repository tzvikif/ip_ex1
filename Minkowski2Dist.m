function d = Minkowski2Dist(im1,im2)
%%the function calculte the distance between 2 normalize histograms
%%able to calculte diffrente sized images
    P = 2;
    figure;
    h1 = histogram(im1(:),256,"Normalization","probability");
    %%creating a vector from the histogram
    val1 = h1.Values;
    figure;
    h2 = histogram(im2(:),256,"Normalization","probability");
    val2 = h2.Values;
    %%culclate minkowski distance
    d =(sum((abs(val1-val2)).^P))^1/P;
    %%closing the histograms
    close all;
    %%return velue d the minkowski distance between im1 and im2
end