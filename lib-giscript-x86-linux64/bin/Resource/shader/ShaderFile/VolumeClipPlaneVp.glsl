attribute vec4 vertex;

uniform mat4 worldviewproj_matrix;
uniform mat4 worldview_matrix;
uniform mat4 viewToTextureMatrix;

varying vec4 texCoord;

void main()
{
	vec4 viewPos = worldview_matrix * vertex;
	texCoord = viewToTextureMatrix * viewPos;

	// ��������任
	gl_Position = worldviewproj_matrix * vertex;
}
