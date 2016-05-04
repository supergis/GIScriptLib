attribute vec4 vertex;
attribute vec3 normal;
attribute vec4 uv0;
attribute vec4 uv1;

uniform mat4 worldview_matrix;
uniform mat4 projection_matrix;
uniform mat4 texture0_matrix;
uniform mat4 texture1_matrix;

varying vec4 texCoord;
varying vec2 tex1Coord;

void main()
{
	// 计算纹理坐标
	texCoord = texture0_matrix * uv0;
	tex1Coord = vec2(texture1_matrix * uv1);

	// 计算顶点坐标值
	vec4 viewPos = worldview_matrix * vertex;
	viewPos.xyz += normal;
	gl_Position = projection_matrix * viewPos;
}
