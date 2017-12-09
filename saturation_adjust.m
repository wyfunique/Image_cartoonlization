function img_res = saturation_adjust( img, S_scalar )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Adjust the saturation of input image.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    img_double = double(img);
    img_gray = double(rgb2gray(img));
    S_template = img_double;
    
    % S_template -- Saturation changing template.
    % For saturation changing, we normally use a grayscale version of original image as templete to complete the interpolation and extrapolation. 
    % If you are not familiar with the interpolation and extrapolation, see here: http://netpbm.sourceforge.net/doc/extendedopacity.html
    S_template(:,:,1)=img_gray; S_template(:,:,2)=img_gray;S_template(:,:,3)=img_gray;
    
    % Implement interpolation and extrapolation. 
    img_res = (1-S_scalar).*S_template  +S_scalar.*img_double;
    
    img_res = uint8(img_res);
end

