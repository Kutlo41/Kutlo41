%% Marker Controlled Watershed Segmentation

%% Reading the images and converting them to GrayScale

img1 = imread('invasive.jpg');
img2 = imread('noninvasive2.jpg');

i1 = rgb2gray(img1);
n1 = rgb2gray(img2);

subplot(2,2,1)
imshow(i1)
subplot(2,2,2)
imshow(n1)

%% Using the Gradient Magnitude as the Segmentation Function

gmag1 = imgradient(i1);
gmag2 = imgradient(n1);

subplot(2,2,1)
imshow(gmag1,[])
title('Invasive Gradient Magnitude')

subplot(2,2,2)
imshow(gmag2,[])
title('Non Invasive Gradient Magnitude')

%% watershed transformation of Gradient Magnitude

L1 = watershed(gmag1);
L2 = watershed(gmag2);

Lrgb1 = label2rgb(L1);
Lrgb2 = label2rgb(L2);

subplot(2,2,1)
imshow(Lrgb1)
title('Watershed Transform')

subplot(2,2,2)
imshow(Lrgb2)
title('Watershed Transform')

%% Marking the Foreground Objects

se = strel('disk',20);

Io1 = imopen(img1,se);
Io2 = imopen(img2,se);

subplot(2,2,1)
imshow(Io1)
title('Invasive Image Opening')

subplot(2,2,2)
imshow(Io2)
title('NonInvasive Image Opening')

%% computing the opening-by-reconstruction

Ie1 = imerode(img1,se);
Iobr1 = imreconstruct(Ie1,img1);
subplot(2,2,1)
imshow(Iobr1)
title('Invasive Opening-by-Reconstruction')

Ie2 = imerode(img2,se);
Iobr2 = imreconstruct(Ie2,img2);
subplot(2,2,2)
imshow(Iobr2)
title('NonInvasive Opening-by-Reconstruction')

%% computing the opening with a closing can remove the dark spots and stem marks

Ioc1 = imclose(Io1,se);
subplot(2,2,1)
imshow(Ioc1)
title('Invasive Opening-Closing')

Ioc2 = imclose(Io2,se);
subplot(2,2,2)
imshow(Ioc2)
title('NonInvasive Opening-Closing')

%% complementing the image inputs and output of imreconstruct.

Iobrd1 = imdilate(Iobr1,se);
Iobrcbr1 = imreconstruct(imcomplement(Iobrd1),imcomplement(Iobr1));
Iobrcbr1 = imcomplement(Iobrcbr1);
subplot(2,2,1)
imshow(Iobrcbr1)
title('Invasive Opening-Closing by Reconstruction')

Iobrd2 = imdilate(Iobr2,se);
Iobrcbr2 = imreconstruct(imcomplement(Iobrd2),imcomplement(Iobr2));
Iobrcbr2 = imcomplement(Iobrcbr2);
subplot(2,2,2)
imshow(Iobrcbr2)
title('NonInvasive Opening-Closing by Reconstruction')

%% Edge Detection on Images

% Robert Operator
    
   %% Invasive Plant
   
Filter = edge(i1, 'roberts');
 
subplot(2,2,1);
imshow(img1) 
title('Original Image')

subplot(2,2,2); 
imshow(i1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

    %% NonInvasive Plant

Filter = edge(n1, 'roberts');
 
subplot(2,2,1);
imshow(img2) 
title('Original Image')

subplot(2,2,2); 
imshow(n1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

% Prewitt Operator

     %% Invasive Plant

Filter = edge(i1, 'prewitt');

subplot(2,2,1);
imshow(img1) 
title('Original Image')

subplot(2,2,2); 
imshow(i1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

    %% NonInvasive Plant

Filter = edge(n1, 'prewitt');

subplot(2,2,1);
imshow(img2) 
title('Original Image')

subplot(2,2,2); 
imshow(n1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

% Sobel Operator

   %% Invasive Plant

Filter = edge(i1, 'sobel');

subplot(2,2,1);
imshow(img1) 
title('Original Image')

subplot(2,2,2); 
imshow(i1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

 %% NonInvasive Plant

Filter = edge(n1, 'sobel');

subplot(2,2,1);
imshow(img2) 
title('Original Image')

subplot(2,2,2); 
imshow(n1) 
title('Gray Image')

subplot(2,2,3); 
imshow(Filter) 
title('Detected Edges')

%% Image Segmentation Based on Thresholding

%% Simple thresholding at 0.3

level = 0.3;

%% Display the threshold image

segimage1 = im2bw(i1,level);
segimage2 = im2bw(n1,level);

subplot(2,2,1)
imshow(segimage1); 
title('Simple Thresholding at 0.3'); 
subplot(2,2,2)
imshow(segimage2); 
title('Simple Thresholding at 0.3');

%% Displaying the threshold image

subplot(2,2,1)
imshow(i1 > 153); 
title('Simple Thresholding at 0.6');
subplot(2,2,2)
imshow(n1 > 153);
title('Simple Thresholding at 0.6');

%% the threshold using Otsu Algorithm

    %% greythresh Level

level = graythresh(i1);

level1 = graythresh(n1);

    %% Display the threshold image

subplot(2,2,1);
segimagee1 = im2bw(i1,level);
imshow(segimagee1); 
title('Otsu - Optimal Segmented Image');

subplot(2,2,2);
segimagee2 = im2bw(n1,level1);
imshow(segimagee2); 
title('Otsu - Optimal Segmented Image');