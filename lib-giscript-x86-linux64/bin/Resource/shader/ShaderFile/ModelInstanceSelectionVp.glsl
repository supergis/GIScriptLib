//---------------------------------------------------------------------------
//These materials/shaders are part of the NEW InstanceManager implementation
//Written by Matias N. Goldberg ("dark_sylinc")
//---------------------------------------------------------------------------
#version 120

//Parameters
attribute vec4 uv1;
attribute vec4 uv2;
attribute vec4 uv3;
attribute vec4 uv4;
attribute vec4 secondary_colour;

varying vec4 vecVertexColor;
varying vec4 clip_vertex;

void main(void)
{
	mat4 worldMatrix;
	worldMatrix[0] = uv1;
	worldMatrix[1] = uv2;
	worldMatrix[2] = uv3;
	worldMatrix[3] = vec4( 0, 0, 0, 1);

	vec4 worldPos = gl_Vertex * worldMatrix;
	//Transform the position
	gl_Position = gl_ModelViewProjectionMatrix * worldPos;
	gl_ClipVertex = gl_ModelViewMatrix * worldPos;
	clip_vertex = gl_ClipVertex;

	vecVertexColor = vec4(0.0, 0.0, 0.0, 0.0);
	if(uv4.w > 0.0)
	{
		vecVertexColor = secondary_colour;
	}
}
