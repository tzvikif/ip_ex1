function [nim,a,b] = contrastEnhance(im,range)
%%the function enhance the contrast in the image
%%by maximizing the range of the grey scale
%%we create a linar mapping from old color to a new one 
    oldMinColor = min(im(:));
    oldMaxColor = max(im(:));
 %%creating the linar mapping
    a = (range(2) - range(1))/(oldMaxColor-oldMinColor);
    b = range(2) - a*oldMaxColor;
    nim=round(a*im+b);
%%return values are the mapped image
%%and the a,b used to map
end