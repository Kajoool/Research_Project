# Analyzing Image Processing Techniques for Lung Cancer Detection

## Table of Contents
1) [Introduction](#Introduction)
2) [Data_visualization](#Data_visualization)
3) [Methods_Results](#Methods_Results)
4) [Analysis](#Analysis)
5) [Conclusion](#Conclusion)
6) [License](#License)
7) [References](#References)

## Introduction
Lung cancer is now one of the deadliest cancers worldwide. However, the early detection of lung cancer significantly improves survival rate. Various diagnostic procedures are used by physicians, in connection, for the early diagnosis of malignant lung nodules, such as clinical settings, computed tomography (CT) scan analysis (morphological assessment), positron emission tomography (PET) (metabolic assessments), and needle prick biopsy analysis . However, mostly invasive methods such as biopsies or surgeries are used by healthcare practitioners to differentiate between benign and malignant lung nodules. The earlier the detection, the higher is the possibility of successful treatment This accounts for an expected 9.6 million passing or one of every six deaths from last three years. To be precise lung cancer represents 2.06 million cases and 1.76 million passing. Cancer cells can be carried away from lungs in blood, or lymph fluid that surrounds lung tissue. Lymph streams through lymphatic vessels, which drain into lymph nodes placed in lungs and in centre of the chest. Lung cancer often spreads towards the centre of chest as it is the natural flow of lymph. Cancer that initiates in lungs is known as primary lung cancer. There are multiple types of lung cancer and further they are separated in two main groups: small cell lung cancer and non-small lung cancer. An estimate of lung cancer found in males and in females due to smoking is 85% and 75% respectively. 

The method of early detection of cancer plays a crucial role to prevent cancer cells from multiplying and spreading. Previous researchers have been conducted for analysing lung cancer using clustering method in microarray data, lung cancer detection with general image processing techniques in CT scan data with good accuracy and results. In the first phase I get CT scan image data. Further I implemented image enhancement to improve quality of image. The third step is image segmentation which is vital step for detection of cancer. The fourth phase is feature extraction that will give a conclusion whether lung cancer is present or not.

Visually identifying and examining these images for potential abnormalities is a challenging and time consuming task due to the large amount of information that needs to be processed, and the short amount of time given. The subject of medical image mining is currently an upcoming topic and shows a lot of research potential in the area of computational intelligence. By auto-analysing a patient???s records and images through image processing techniques, we would reduce the risk of human error in module detection. By applying a combination of techniques in data pre-processing, feature extraction, and classification, we ultimately seek to increase the accuracy rate of cancer detection, while simultaneously reducing the false positive diagnosis rate. Many researchers proposed many solutions and challenges of different phases of computer aided system to detect the lung cancer in early stages and give the facts about the lung cancer. 

## Data_Visualization
Visualization of dataset is an important part of training; it gives better understanding of dataset. But CT scan images are hard to visualize for a normal pc or any window browser. Therefore we use the pydicom library to solve this problem. The Pydicom library gives an image array and metadata information stored in CT images like patient???s name, patient???s id, patient???s birth date, image position, image number, doctor???s name, doctor???s birth date etc. Luna16 dataset is a directory which contains many subdirectories named on patient???s ids. A complete subdirectory is 3d image of lungs which is stored in around 180 2d image slices according to their image number.

![image](https://user-images.githubusercontent.com/70322066/129493442-64383928-ab89-40de-8a85-2bdefe802eb0.png)

After combining all images in a single subdirectory according to their image it represents a 3d image. 3d image of lungs gives a vast idea about lung cancer cells and other diseases in lungs. Below we can see a 3-dimensional image:

![image](https://user-images.githubusercontent.com/70322066/129493458-b526ca10-ab55-4b65-8092-f89325dda885.png)

## Methods_Results
1)	Image acquisitions:
The pictures used are from CT scan database. The Data is from the VIA and ELCAP Public Access Dataset [1].

![image](https://user-images.githubusercontent.com/70322066/129493623-6262c3c8-ed0e-436f-b1a5-a7630a443f09.png)

2)	Image segmentation:
This is a crucial process for most image analysis subsequent tasks. Segmentation partitions image into constituent regions or objects. The goal here is to simplify or change the representation of image such that it is more meaningful and easier to analyse. Algorithm for segmentation is based on two properties: discontinuity and similarity. Discontinuity is to divide image into similar regions like in edges in an image. Similarity category is based on partitioning image into similar regions according to predefined criterion.

            a) Image segmentation by region growing:
  The procedure to extend the covered area by collecting pixels or sub-regions based on predetermined criteria is known as region growing. The approach is to initiate a set point and then expand the area surrounding the point; the area has same range of colour or grey level. The below figure shows segmention by region growing method:
  
   ![image](https://user-images.githubusercontent.com/70322066/129493648-ad982aef-5f7c-4010-a1e0-69da1ba0a86d.png)

       b) Image segmentation by marker controlled watershed:
   The process to get segmentation by watershed method is as follows; calculate the distance gradient for edge detection and then mark the target object by using a morphological technique called opening by reconstruction and closing by reconstruction. The below figure shows segmentation by marker controlled watershed.
   
   ![image](https://user-images.githubusercontent.com/70322066/129493707-7c289dd8-f8b0-41ac-ab54-00c8105e3838.png)


      c) Image segmentation by marker controlled watershed with masking:
   Segmentation with marker controlled watershed with masking method is the same process as above with additional masking which marks the area that contains the target object at the right and left lung.This figure shows Segmentation by marker controlled watershed with masking method.
   
   ![image](https://user-images.githubusercontent.com/70322066/129493723-5f31fc02-990c-4051-8434-e3b4f763c63b.png)

3) Waterhed Algorithm:
The watershed is a classical algorithm used for segmentation, that is, for separating different objects in an image. a watershed is a transformation defined on a grayscale image. The name refers metaphorically to a geological watershed, or drainage divide, which separates adjacent drainage basins. The watershed transformation treats the image it operates upon like a topographic map, with the brightness of each point representing its height, and finds the lines that run along the tops of ridges. The watershed algorithm treats pixels values as a local topography (elevation). The algorithm floods basins from the markers until basins attributed to different markers meet on watershed lines. In many cases, markers are chosen as local minima of the image, from which basins are flooded. First, we extract internal and external markers from CT scan images with the help of binary dilations and add them with a complete dark image using watershed methods. And it removes external noise from the image and gives a watershed marker of lungs and cancer cells. As we can see in the below figure watershed marker removes external noise and applies a binary mask on the image , black pixels in lungs represent cancer cells.

![image](https://user-images.githubusercontent.com/70322066/129493795-3f3821a7-beaa-4c2f-8314-d0e10747d159.png)

By doing this in total 1002 images with related labels were generated, which includes almost 5 patients CT scan data in which there are almost the same number of cancer and non-cancer patients.

4) Binarization:
The process of changing the colour of pixel values into two classes [2], such as black and white. On getting the quantity of black and white pixels on segmentation results, it was compared with a threshold value to determine the condition of lung. Below table 2  shows the result of detection from five sample patients through pixelization.

![image](https://user-images.githubusercontent.com/70322066/129493878-eeeb0305-0b58-47cd-b692-f820ac93bfcf.png)

![image](https://user-images.githubusercontent.com/70322066/129493890-150c0fa4-c423-44cc-80bd-890a6198953f.png)

## Analysis

Three Methods Segmentation Analysis:

The analysis of three segmentation methods based on their success on segmentation results of target object can be seen in figure below. Figure 8 shows that two methods have successfully found the target object including a) region growing and c) marker controlled watershed with masking. On the other hand, b) marker controlled watershed segmentation has failed to get segmentation results since there is background surrounding the target object.

![image](https://user-images.githubusercontent.com/70322066/129493921-7c0bc469-ca31-42f4-b0a4-998852e69c2c.png)

Table below shows the comparison of running time of region growing method and marker controlled watershed segmentation with masking. Here marker controlled watershed method b) is not included in the comparison as it failed to get segmentation results. 

![image](https://user-images.githubusercontent.com/70322066/129493925-452ef004-aa31-4a66-bf58-2c7b40942498.png)


## Conclusion

After evaluating three methods of image segmentation for detecting lung cancer, such as Region Growing, Marker Controlled Watershed, and Marker Controlled Watershed with Masking, the results show that performance of Marker Controlled Watershed with masking method is the best in terms of segmentation result and running time. Therefore, I select Marker Controlled Watershed with masking method in image segmentation stage. Image quality and accuracy were the core factors of this research.

## License
For my current project on **Analyzing Image Processing Techniques for Lung Cancer Detection**, I have used Mozilla Public License Version 2.0 as my license so that the project can be shared and viewed publically.

## References
[1] Lung Cancer Database, Available at: https://eddie.via.cornell.edu/cgibin/datac/signon.cgi

[2] Sarwinda D and Bustamam A 2016 Detection of Alzheimers disease using advanced local binary pattern from hippocampus and whole brain of MR images International Joint Conference on Neural Networks (IJCNN) IEEE pp 5051???5056






