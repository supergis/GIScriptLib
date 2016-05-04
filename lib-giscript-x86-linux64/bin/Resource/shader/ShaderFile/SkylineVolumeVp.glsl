
uniform mat4 vertexToTexcoordMatrix;
varying vec4 texCoord;
void main()
{
	vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
	texCoord = vertexToTexcoordMatrix * viewPos;
		
	gl_Position = ftransform();
}