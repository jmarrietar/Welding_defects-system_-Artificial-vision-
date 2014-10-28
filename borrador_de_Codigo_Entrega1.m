I=imread('IMG_6438.jpg');
cform = makecform('srgb2lab');
lab = applycform(I,cform);
imshow(lab)
YCBCR = rgb2ycbcr(I);
imshow(YCBCR)
HSV=rgb2hsv(I);
imshow(HSV);
gris=rgb2gray(I);
gris=medfilt2(255-gris,[5 5]);
imshow(gris);
imhist(gris)
inversa=255-gris;
imhist(inversa)
inversa(inversa<50)=0;
imhist(inversa)
minimo = nlfilter(inversa,[11 11],@minFil);
imshow(minimo);
I=minimo;
figure,imshow(I);
thresh = multithresh(I,2);
seg_I = imquantize(I,thresh);
RGB = label2rgb(seg_I);
figure, imshow(RGB);
level = graythresh(I);
BW = im2bw(I,level);
figure, imshow(BW)
Ialt=I;
Ialt(Ialt>10)=255;
figure,imshow(Ialt)