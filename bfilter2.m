function B = bfilter2(A,w,sigma)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pre-process input and select appropriate filter.    
% Verify that the input image exists and is valid.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~exist('A','var') || isempty(A)  
        error('Input image A is undefined or invalid.');  
    end  
    if ~isfloat(A) || ~sum([1,3] == size(A,3)) || min(A(:)) < 0 || max(A(:)) > 1  
        error(['Input image A must be a double precision ',...  
          'matrix of size NxMx1 or NxMx3 on the closed ',...  
          'interval [0,1].']);        
    end  
  
    % Verify bilateral filter window size.  
    if ~exist('w','var') || isempty(w) || numel(w) ~= 1 || w < 1  
        w = 5;  
    end  
    w = ceil(w);  
    
    % Verify bilateral filter standard deviations.  
    if ~exist('sigma','var') || isempty(sigma) || numel(sigma) ~= 2 || sigma(1) <= 0 || sigma(2) <= 0  
        sigma = [3 0.1];  
    end  
  
    % Apply either grayscale or color bilateral filtering.  
    if size(A,3) == 1  
        B = bfltGray(A,w,sigma(1),sigma(2));  
    else  
        B = bfltColor(A,w,sigma(1),sigma(2));  
    end 
end
