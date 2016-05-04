
varying float fHeight;

void main(void)
{
	vec4 oPos = gl_ModelViewProjectionMatrix * gl_Vertex;

	gl_Position = oPos;
	gl_ClipVertex = gl_ModelViewMatrix * gl_Vertex;
	fHeight = gl_Vertex.z;
}
