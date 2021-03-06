//Author: Puzhi Yao
//Date: 18 May 2015
//Program description:
//CG Assignment 3 SKY GLASS KITCHEN

/*********************************************************
Version 1.000

Code provided by Michael Hemsley and Anthony Dick
for the course 
COMP SCI 3014/7090 Computer Graphics
School of Computer Science
University of Adelaide

Permission is granted for anyone to copy, use, modify, or distribute this
program and accompanying programs and documents for any purpose, provided
this copyright notice is retained and prominently displayed, along with
a note saying that the original programs are available from the aforementioned 
course web page. 

The programs and documents are distributed without any warranty, express or
implied.  As the programs were written for research purposes only, they have
not been tested to the degree that would be advisable in any important
application.  All use of these programs is entirely at the user's own risk.
*********************************************************/

#version 130

// manyAttributes.vp
// This shader passes on colour values to be interpolated by the fixed functionality
// 

uniform mat4 projection_matrix;
uniform mat4 view_matrix;
uniform mat4 model_matrix;


in vec3 a_vertex;
in vec3 a_normal;
in vec4 a_colour;	
in vec2 a_tex_coord;


// This colour attribute will be sent out per-vertex and the fixed-functionality
// interpolates the colour (smooths the colour between) with connected vertices in the triangle
out vec4 colour;

out vec2 st;
out vec3 Position_worldspace;
out vec3 EyeDirection_cameraspace;
out vec3 Normal_cameraspace;

void main(void) {
	
	colour = a_colour;	// We simply pass the colour along to the next stage

   	st = a_tex_coord;
   	
    Position_worldspace = (model_matrix * vec4(a_vertex, 1.0)).xyz;
    
    mat4 inveseTransposeModelMatrix = transpose(inverse(model_matrix));
    Normal_cameraspace = ( view_matrix * inveseTransposeModelMatrix * vec4(a_normal,0)).xyz;
    
    // Vector that goes from the vertex to the camera, in camera space.
    // In camera space, the camera is at the origin (0,0,0).
    vec3 vertexPosition_cameraspace = ( view_matrix * model_matrix * vec4(a_vertex, 1.0)).xyz;
    EyeDirection_cameraspace = vec3(0,0,0) - vertexPosition_cameraspace;
    
    //vec3 LightPosition_cameraspace = ( view_matrix * vec4(  LightPosition_worldspace,1)).xyz;
    //LightDirection_cameraspace =  LightPosition_cameraspace + EyeDirection_cameraspace;
   	
	gl_Position = projection_matrix * view_matrix * model_matrix * vec4(a_vertex, 1.0); 

}
