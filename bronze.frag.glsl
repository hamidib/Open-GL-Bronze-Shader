# version 120
/*
 * Michael Shafae
 * mshafae at fullerton.edu
 * 
 * A simple Blinn-Phong shader with two light sources.
 * This file is the fragment shader which calculates
 * the halfway vector between the viewer and light source
 * vector and then calculates the color on the surface
 * given the material properties passed in from the CPU program.
 *
 * For more information see:
 *     <http://en.wikipedia.org/wiki/Blinn–Phong_shading_model>
 *
 * $Id: blinn_phong.frag.glsl 4891 2014-04-05 08:36:23Z mshafae $
 *
 * Be aware that for this course, we are limiting ourselves to
 * GLSL v.1.2. This is not at all the contemporary shading
 * programming environment, but it offers the greatest degree
 * of compatability.
 *
 * Please do not use syntax from GLSL > 1.2 for any homework
 * submission.
 *
 */

// These are passed from the vertex shader to here, the fragment shader
// In later versions of GLSL these are 'in' variables.
varying vec3 myNormal;
varying vec4 myVertex;

// These are passed in from the CPU program, camera_control_*.cpp
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 normalMatrix;
uniform vec4 light0_position;
uniform vec4 light0_color;
uniform vec4 light1_position;
uniform vec4 light1_color;

vec4 ComputeLight (const in vec3 eyeV, const in vec3 direction, const in vec4 lightcolor, const in vec3 normal, const in vec3 halfvec){

  vec3 w = vec3(1, 1, 1);
  vec3 p = vec3(1, 2, 20);
  
  //R = 2 * (I . N) * N - I
  float nDotL = dot(normal, direction);
  vec3 reflection = normalize((2 *normal * nDotL) - direction);
    
  float eDotR = dot (eyeV, reflection);//halfvec);
  float myColor1 = w.x * pow( ((eDotR+1)/2), p.x );//for each color
  float myColor2 = w.y * pow( ((eDotR+1)/2), p.y );//for each color
  float myColor3 = w.z * pow( ((eDotR+1)/2), p.z );//for each color
  vec4 retval = vec4(myColor1, myColor2, myColor3, 0);//add computed colors into vector
  return retval;
}       

void main (void){
  //vec4 ambient = vec4(0.2, 0.2, 0.2, 1.0);
  //vec4 diffuse = vec4(0.5, 0.5, 0.5, 1.0);
  //vec4 specular = vec4(1.0, 1.0, 1.0, 1.0);
  //float shininess = 100;
  
  // They eye is always at (0,0,0) looking down -z axis 
  // Also compute current fragment position and direction to eye 

  const vec3 eyepos = vec3(0,0,0);
  vec4 _mypos = modelViewMatrix * myVertex;
  vec3 mypos = _mypos.xyz / _mypos.w;
  vec3 eyedirn = normalize(eyepos - mypos);

  // Compute normal, needed for shading. 
  vec4 _normal = normalMatrix * vec4(myNormal, 0.0);
  vec3 normal = normalize(_normal.xyz);

  // Light 0, point
  vec3 position0 = light0_position.xyz / light0_position.w;
  vec3 direction0 = normalize (position0 - mypos);
  vec3 half0 = normalize(direction0 + eyedirn); 
  vec4 color0 = ComputeLight(eyedirn, direction0, light0_color, normal, half0) ;

  // Light 1, point 
  vec3 position1 = light1_position.xyz / light1_position.w;
  vec3 direction1 = normalize(position1 - mypos);
  vec3 half1 = normalize(direction1 + eyedirn); 
  vec4 color1 = ComputeLight(eyedirn, direction1, light1_color, normal, half1) ;
    
    gl_FragColor = color0 + color1;
}
