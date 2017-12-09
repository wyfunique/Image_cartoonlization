img = imread('your image path');
figure(1); imshow(img);
img_copy = img;
img_res = img;

% Key arguments -- please determine them according to specific images.

% Threshold for edge determining.
edge_thresh = 0.02;

edge_operator = 'sobel'; 

saturation_scalar = 2;

% Arguments for Bilateral filter.
radius=10; sigma=[3, 0.1]; 
loop_num = 1; 

% Adjust the saturation of img.
img_sa = saturation_adjust(img, saturation_scalar);

% Normalize image to [0,1].
img_f = (double(img_sa)) ./ 255;


if loop_num > 1
    img_f = bfilter2(img_f,radius,sigma);
    img_gray = rgb2gray(img_f);
    
    % Represent the edges using a mask.
    edge_mask = uint8(edge(img_gray, edge_operator, edge_thresh));
    
    for i=2:loop_num
        img_f = bfilter2(img_f,radius,sigma);
    end
elseif loop_num == 1
    img_f = bfilter2(img_f,radius,sigma);
    img_gray = rgb2gray(img_f);
    edge_mask = uint8(edge(img_gray, edge_operator, edge_thresh));    
end   

figure(2); imshow(img_f);

% Convert double-type image to uint8-type image for highlighting edges.
img_blur = uint8(img_f*255);

% Highlight edges using black color.
img_res(:,:,1) = img_blur(:,:,1) - img_blur(:,:,1) .* edge_mask;
img_res(:,:,2) = img_blur(:,:,2) - img_blur(:,:,2) .* edge_mask;
img_res(:,:,3) = img_blur(:,:,3) - img_blur(:,:,3) .* edge_mask;

figure(3); imshow(img_res);
