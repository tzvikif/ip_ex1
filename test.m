
%%Initialization
clear;close all;clc

fprintf('read darkImage.tif...\n');
darkim = readImage('darkimage.tif');
mypause;
fprintf('displaying darkimage.tif \n');
showImage(darkim);
mypause;
close all;
%%
%%using contrastEnhance on darkimage
fprintf('-----------------\n');
fprintf('test A. maximizing contrast in image darkimage\n');
[ndarkim,a,b] = contrastEnhance(darkim,[0,255]);
fprintf('displaying enhanced contrast darkimage.tif \n');
showImage(ndarkim);
fprintf('the values of the tone map: a = %f, b = %f\n',a,b);
fprintf('display tone mapping\n');
%%using SLTmap to create the tone map
[nim,TM] = SLTmap(darkim,ndarkim);
plot(0:255,TM, 'rx');
    title('Tone mapping');
    xlabel('original image color');
    ylabel('enhanced contrast image color');
mypause;
close all;
%%
%%using contrastEnhance on fourSqaures.tif
fprintf('-----------------\n');
fprintf('test B. maximizing contrast of elready fully enhance\n');
fprintf('reading fourSqaures.tif which is already an enhanced image\ntrying to enhance fourSqaures.tif\n');
fsq = readImage('fourSquares.tif');
[fsq1,a,b] = contrastEnhance(fsq,[0,255]);
fprintf('the values of the tone map: a = %f, b = %f\n',a,b);
fprintf('as can be seen the tone map change nothing\n');
fprintf('also per pixel diff between the images is %f\n',sum(fsq-fsq1,'all'));
mypause;
%%
%%using Minkowski2Dist on darkimage
fprintf('-----------------\n');
fprintf('test C. Minkowski distance\n');
fprintf('C.1. the Minkowski distance between image and itself\n');
fprintf('the Minkowski distance between image and itself d:%f\n',Minkowski2Dist(darkim,darkim));
mypause;
fprintf('C.2. the Minkowski distance between image and decreased image\n');
minVal = min(darkim(:));
maxVal = max(darkim(:));
range = maxVal - minVal;
X = linspace(1,range,range);
Y = zeros(1,range);
%%darkimage contrast with a moving up range   
for i=1:range
    [nim,a,b] = contrastEnhance(darkim,[minVal,minVal + i]);
    Y(i) = round(Minkowski2Dist(darkim,nim)*100);
end
plot(X,Y);
mypause;
close all;

%%
%%using sliceMat on lena.tif
fprintf('-----------------\n');
fprintf('test D. sliceMat(im) * [0:255]'' == im\n');
lena = readImage('lena.tif');
sizeX = size(lena,1);
sizeY = size(lena,2);
%%calculte new image using the slice matrix and a vector 0:255as tone map
Nlena = reshape(sliceMat(lena) * (0:255)',sizeY,sizeX);
diff = lena - Nlena;
fprintf('diff between lena && reshape(sliceMat(lena) * [0:255]'',sizeY,sizeX): %f\n',sum(diff(:)));
mypause;
%%
fprintf('-----------------\n');
fprintf('test E. sliceMat(im) * TM produces a tone mapped version of im\n');
fprintf('use darkimage and contrast darkimage\n');
%%find the tone map 
[nim,TM] = SLTmap(darkim,ndarkim);
SL = sliceMat(darkim);
fprintf('Displaying origional image \n');
showImage(darkim);
mypause;
fprintf('Displaying enhance contrast image \n');
showImage(ndarkim);
mypause;
fprintf('Displaying sliceMat(darkImage)*TM image \n');
Ndarkim = reshape(SL*TM',size(darkim,1),size(darkim,2));
showImage(Ndarkim);
mypause;
%%comparing the images
diff = sum(abs(Ndarkim - ndarkim),'all');
fprintf('the diffrante between contrast enhanced im with sliceMat(im) * TM is %f \n', diff);
mypause;
%%
fprintf('------------------------\n');
fprintf('test F. Using sliceMat(im) * TM produce the negative image of im\n');
negativeTM = 255 - TM;
showImage(reshape(SL*negativeTM',size(darkim,1),size(darkim,2)));
mypause;
%%
fprintf('-------------------------------------\n');
fprintf('test G. Using sliceMat(im) * TM produce a binary image by defining TM that performs thresholding\n');
fprintf('of im, using threshold 120\n');
binaryTM = 255*(TM > 120);
showImage(reshape(SL*binaryTM',size(darkim,1),size(darkim,2)));
mypause;
%%
fprintf('--------------\n');
fprintf('test H. SLTmap\n');
fprintf('test H.1 displaying images:\n');
[nim,TM] = SLTmap(lena,darkim);
fprintf('Displaying im1 image \n');
showImage(lena);
mypause;
fprintf('Displaying SLTmap(im1,im2) image\n');
showImage(nim);
mypause;
fprintf('Displaying im2 \n');
showImage(darkim);
mypause;
clear all;
fprintf('test H.2 meanSqrDist distance between SLTmap(im1,im2) and im2 is smaller than the\n');
fprintf(' distance between im1 and im2\n');
dist1 = MeanSqrDist(lena,nim);
dist2 = MeanSqrDist(nim,darkim);
fprintf('mean square Distnace between im1 and SLTmap(im1,im2): %f\n',dist1);
fprintf('mean square Distnace between im2 and SLTmap(im1,im2): %f\n',dist2);
fprintf('Conclusion: %f > %f thus showing that the distance between im1 and SLTmap(im1,im2) is higher \nthen the distance between im2 and SLTmap(im1,im2)\n',dist1,dist2);
mypause;
%%
fprintf('----------\n');
fprintf('test I.\n');
fprintf('test I.1 histogram matching to map im1 to have histogram as similar as possible to im2\n');
[im3,TM] = histMatch(lena,darkim);
fprintf('test I.2 meanSqrDist distance between SLTmap(im1,im2) and im2 is smaller than the\n')
fprintf(' distance between im3 and im2\n');
dist3 = MeanSqrDist(im3,darkim);
fprintf('displaying all four images\n');
fprintf('Displaying im1 image \n');
showImage(lena);
mypause;
fprintf('Displaying SLTmap(im1,im2) image\n');
showImage(nim);
mypause;
fprintf('Displaying im2 \n');
showImage(darkim);
mypause;
fprintf('Displaying im3 histogram matching \n');
showImage(im3);
mypause;
fprintf('mean square Distnace between im1 and SLTmap(im1,im2): %f\n',dist2);
fprintf('mean square Distnace between im2 and histMatch(im1,im2): %f\n',dist3);
fprintf('Conclusion: %f > %f thus showing that the distance between im1 and SLTmap(im1,im2) is higher \nthen the distance between im1 and histMatch(im1,im2)\n',dist3,dist2);
mypause;
%%
fprintf('-------------------------------------\n');
fprintf('test J. recreating tone map using SLTmap\n');
fprintf('creating a new image from a tone map \nthe current image \n');
showImage(lena);
fprintf('the image mapped by the tone map \n');
%%making a nice tone map that enhance the image and then nagtive 
[nim,a ,b] = contrastEnhance(lena, [0 255]);
mappedIm = 255 - nim;
showImage(mappedIm);
fprintf('applying STLmap on the images\n');
[SLTmappedIM, TM] = SLTmap(lena, mappedIm);
fprintf('Minkowski distance between SLTmapped imade and the tone mapped one: %f\n', Minkowski2Dist(mappedIm,SLTmappedIM));
fprintf('Mean Square distance between SLTmapped imade and the tone mapped one: %f\n', MeanSqrDist(mappedIm,SLTmappedIM));
mypause;
%%
fprintf('-------------------------------------\n');
fprintf('test K. is SLTmap symmetric\n');
%%creating two images one where lena mapped to darkimage
%%the other darkimage mapped to lena
[nim1,TM1] = SLTmap(lena,darkim);
[nim2,TM2] = SLTmap(darkim,lena);
%%checking if the images are identical 
if(sum(~(nim1(:) == nim2(:))) == 0)
    fprintf('SLTmap is symmetric\n');
else
    fprintf('SLTmap not symmetric\n'); 
end
mypause;
close all;
clc
%%
