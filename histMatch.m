function [nim TM] =  histMatch(im1,im2);
% Performs histogram matching. Tone maps im1 so as to have histogram
% similar to that of im2
% Input: im1, im2 - 2D grayscale images
% Output: nim - the tone mapped image
%             TM the tone maping given a sa vector 256X1
%

TM = zeros(256,1,'uint8'); %// Store mapping - Cast to uint8 to respect data type
hist1 = hist(double(im1(:)),[0:255]); %// Compute histograms
hist2 =  hist(double(im2(:)),[0:255]);
cdf1 = cumsum(hist1) / numel(im1); %// Compute CDFs
cdf2 = cumsum(hist2) / numel(im2);

%// Compute the mapping
for i = 1 : 256
    [~,ind] = min(abs(cdf1(i) - cdf2));
    TM(i) = ind-1;  % -1 bcs grayvalues are 0..255 and inx is 1:256
end

%// Now apply the mapping to get first image to make
%// the image look like the distribution of the second image
nim = TM((im1)+1);