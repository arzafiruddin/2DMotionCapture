# 2DMotionCapture

## Description
Takes video of gait motion from sagittal perspective, tracks the position each joint, and creates exportable 2-D wireframe simulation of motion. 

## Methods
### Data Processing
The joints are tracked at their centroid by RGB thresholding each frame of the video into a binary frame for each joint (as shown in *FIGURE 1*) as a matrix (2-dimensional array). The custom function `Centroid.m` determines the binary row and column with the highest binary sums, of which it uses to determine the centroid of the joint in that frame.

### Modeling
The centroids of each joint are seperately recorded for each frame of the given video (as shown in *FIGURE 1*), after which they are used to develop a wireframe model of the observed motion (as shown in *FIGURE 2*).

> NOTE: The model can be exported, which is **highly recommended** for computers which may not have the ability to process the model in real-time at a reasonable viewing speed.

### Figures

*FIGURE 1*

![alt text](https://github.com/arzafiruddin/2DMotionCapture/blob/8f87deecb65559df6036f559b195e3a2a3a4ceb6/readme_assets/walkcentroidgif.gif)
![alt text](https://github.com/arzafiruddin/2DMotionCapture/blob/b146e57270f251babb3d10533a83069d0d94f8ae/readme_assets/kickcentroidgif.gif)

*FIGURE 2*

![alt text](https://github.com/arzafiruddin/2DMotionCapture/blob/2fd88569404e7c9a0b91ddff3749ec48e32f92aa/readme_assets/walkwireframegif.gif)
![alt text](https://github.com/arzafiruddin/2DMotionCapture/blob/27fdb564b5e99c37ca447b0cd576924fdf94214f/readme_assets/kickwireframegif.gif)

## Dependencies
- MATLAB Image Processing Toolkit

## Acknowledgments
- Dr. Naji Husseini, PhD (North Carolina State University - Department of Biomedical Engineering) aided in developed of `Centroid.m` program as part of BMME 201 course
