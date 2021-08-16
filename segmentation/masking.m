Skip to content
Why GitHub? 
Team
Enterprise
Explore 
Marketplace
Pricing 
Search
Sign in
Sign up
Kajoool
/
Research_Project
22
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
Research_Project/segmentation/masking.m
@Kajoool
Kajoool Build 1
Latest commit d702131 on Mar 12, 2018
 History
 1 contributor
Executable File  93 lines (70 sloc)  2.83 KB
  
function maskImageVolume= segmentationMask( intialSegResult,volume_image)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This fucntion is used to get the lung mask for the 3D input CT image and
%   refine each slice to exclude the lobe boundary (other objecsts inside each slice) 
%
%   input:
%           intialSegResult: two phase segmentation result
%           volume_image: the reordered 3D CT image array
%           airwayMask: segmentation result for airway
%   output:
%           maskImageVolume: the binary mask of segmentation result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copy rignt: medical imaging informatics group, UCLA
%%%%%%%%%%%%%%%%%%%%%
%Get lung lobe region

[width,longth,imageIndexTotal]=size(volume_image);
maskImageVolume=intialSegResult;
maskImageBodyRegion=maskImageVolume;
%  viewBinaryMask(maskImageBodyRegion);
for i=1:imageIndexTotal
    maskImageBodyRegion(:,:,i)=imfill(maskImageBodyRegion(:,:,i),'holes');
end

maskImageVolume=~maskImageVolume;
maskImageVolume(~maskImageBodyRegion)=0;
% maskImageVolume=maskImageVolume&(~airwayMask);

% viewBinaryMask(maskImageVolume)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3d-connected component labbling to remove other object
CC = bwconncomp(maskImageVolume);
numPixels = cellfun(@numel,CC.PixelIdxList);
[largest1,idx1] = max(numPixels);
numPixels(idx1)=0;
[largest2,idx2] = max(numPixels);
maskImageVolume= maskImageVolume&0;
maskImageVolume(CC.PixelIdxList{idx1}) = 1;
maskImageVolume(CC.PixelIdxList{idx2}) = 1;

% viewBinaryMask(maskImageVolume);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%morphorlogical operation
SE = strel('disk', 2);
SE1 = strel('disk', 4);
SE2 = strel('disk', 15);
for i=1:imageIndexTotal
      maskImageVolume(:,:,i)=imfill(maskImageVolume(:,:,i),'holes');
%       maskImageVolume(:,:,i)=imopen(maskImageVolume(:,:,i),SE);
%       maskImageVolume(:,:,i)=imerode(maskImageVolume(:,:,i),SE1);
      maskImageVolume(:,:,i)=imclose(maskImageVolume(:,:,i),SE2);
       maskImageVolume(:,:,i)=imerode(maskImageVolume(:,:,i),SE);
      temple= maskImageVolume(:,:,i)&0;
      
       CC = bwconncomp(maskImageVolume(:,:,i));
    if CC.NumObjects~=0
        numPixels = cellfun(@numel,CC.PixelIdxList);
        [largest1,idx1] = max(numPixels);
        total1=largest1/(width*longth);
        numPixels(idx1)=0;
        [largest2,idx2] = max(numPixels);
        total2=largest2/(width*longth);
        temple(CC.PixelIdxList{idx1}) = 1;
        
        if total2~=0
            if (total1/total2)<3
                temple(CC.PixelIdxList{idx2}) = 1;
            end
        end
  
    end
        
     maskImageVolume(:,:,i)=temple;
    
    
    
    
end

    

end

© 2021 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About

