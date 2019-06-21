# Annotation tool for 2D Model annotation from ShapeNet

Here is the folder that contains the requisite code and data for annotating the rendered ShapeNet models. The folder CarAnnotaion36Keypoint contains the following:

1. 02958343              :  Folder containing the ShapeNet models (car class, set the appropriate path)
2. annotate_cars.m  :  Then main matlab script that you would run to annotate 
3. model_names.txt :  Text file containing names of models that we are interested in

Running the code:

1. Open Matlab and change path to the CarAnnotation36Keypoint folder. 
2. Open the annotate_cars.m script
3. Change the modelStartIdx and modelEndIdx (lines 8-9) according to the values assigned to you (see below)
4. Run the code.

modelStartIdx and modelEndIdx values need to be set

Some very important points to note: 

1. The keypoints are to be annotated in an order shown in the image(annotation_sequence.jpg)

2. When you annotate, make sure you are annotating a point that belongs to the car and not the background. In the latter case, the RGB values shown will be [0, 0, 0]. See image below (good_bad_annotation.jpg).

3. Sometimes (what I have found) the data point does not appear on the point where you have actually intended to annotate i.e. the black filled square which appears after clicking on a annotation point does not appear where it should be. In that case it is better you quit the program and re-run the code. 

4, In case you get bored of annotating, you can quit the program anytime you want. However, you should make sure that you quit only in between models and not in between the 3 images of models i.e. you quit only when you are done annotating all the 3 images of the current model.
