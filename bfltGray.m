function B = bfltGray(A,w,sigma_d,sigma_r)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Implements bilateral filtering for grayscale images.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Pre-compute Gaussian distance weights.  
    [X,Y] = meshgrid(-w:w,-w:w);  
    G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));  
  
    % Create waitbar.  
    h = waitbar(0,'Applying bilateral filter...');  
    set(h,'Name','Bilateral Filter Progress');  
  
    % Apply bilateral filter.  
    dim = size(A);  
    B = zeros(dim);  
    for i = 1:dim(1)  
        for j = 1:dim(2)  
            % Extract local region.  
            iMin = max(i-w,1);  
            iMax = min(i+w,dim(1));  
            jMin = max(j-w,1);  
            jMax = min(j+w,dim(2));  
            I = A(iMin:iMax,jMin:jMax);
        
            % Compute Gaussian intensity weights.  
            H = exp(-(I-A(i,j)).^2/(2*sigma_r^2));  
        
            % Calculate bilateral filter response.  
            F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);  
            B(i,j) = sum(F(:).*I(:))/sum(F(:));  
                 
        end  
        waitbar(i/dim(1));  
    end  
  
    % Close waitbar.  
    close(h); 
end