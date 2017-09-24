Name: Bijan A. Hamidi
Date: Sept 23, 2017
Email: bhamidi@csu.fullerton.edu

Description: This is the custom bronze shader program that is built from the phong shader file provided.  The formula Ca=Wa((cos(0) + 1)/2)^Pa is placed within the compute light function located in bronze.frag.glsl.  Each individual color is computed with this calculation as a float(Red Blue Green) then returned in a vec4.  The return value of this function is the color attribute of the fragment.  Theta is determined by taking the dot product of the eye-vector (which I had used eyedirn), and the reflection vector.  Originally I had used the half vector in place of the reflection vector.  However this caused the teapot to glow a very bright golden color. This did tell me I was on the right track.  I found the calculation for the real reflection vector as Reflection = norm((2*N*I)-dir)) where I is theta between the normal and the light vector.   W and P have been defined as vec3 and initialized with the values provided on titanium.  With all of this information I had simply passed all the values into the computelight function to determine the color.  The result was a bronzed teapot!

Light colors were changed in the initLights function located in hello_bronze.cpp on line 166 & line 168.  The values were changed to all 1s.  This change alone had revealed that the teapot was in fact grey.  

To avoid using material properties I avoided using the the diffuse and shininess attributes located in bronze.frag.glsl during calculations.