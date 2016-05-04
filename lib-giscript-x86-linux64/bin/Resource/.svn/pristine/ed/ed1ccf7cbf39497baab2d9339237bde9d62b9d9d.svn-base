attribute vec4 vertex;
attribute vec4 colour;
attribute vec4 uv0;
attribute vec4 uv1;
attribute vec4 uv2;
attribute vec4 uv3;
attribute vec4 uv4;

//Parameters
uniform mat4 texture0_matrix;
uniform mat4 worldview_matrix;
uniform mat4 matInv;

varying vec4 mixColor;
varying vec4 texcoordDepth;

void main()
{
	mat4 worldMatrix;
	worldMatrix[0] = uv1;
	worldMatrix[1] = uv2;
	worldMatrix[2] = uv3;
	worldMatrix[3] = vec4( 0, 0, 0, 1 );

	texcoordDepth = gl_TextureMatrix[0] * uv0;
	
	vec4 worldPos		= vertex * worldMatrix;
	//Transform the position
	gl_Position = gl_ModelViewProjectionMatrix * worldPos;
	gl_ClipVertex = gl_ModelViewMatrix * worldPos;

	texcoordDepth.zw = gl_Position.zw;

	mixColor = colour;
}
