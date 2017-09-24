Name: Bijan A. Hamidi
Date: Sept 23, 2017
Email: bhamidi@csu.fullerton.edu

Description: This is the custom bronze shader program that is built from the phong shader file provided.  The formula Ca=Wa((cos(0) + 1)/2)^Pa is placed within the compute light function located in bronze.frag.glsl.  The return value of this function is the color attribute of the fragment.  Theta is determined by taking the dot product of the eye-vector (which I had used eyedirn), and the reflection vector (I used the halfvec for this).  I believe that the halfvec is the reflection vector as it is calculated with the direction of the light vector(L) and the eye direction (v).  W and P have been defined as vec3 and initalized with the values provided on titanium.  With all of this information I had simply passed all the values into the computelight function to try and determine the color.  The program loads without error, but unfortunally it then quickly closes.  I am still trying to debug this issue.

Light colors were changed in the initLights function located in hello_bronze.cpp on line 166 & line 168.  The values were changed to all 1s.  This change alone had revealed that the teapot was in fact grey.  

To avoid using material properties I avoided using the the diffuse and shininess attributes located in bronze.frag.glsl during calculations.