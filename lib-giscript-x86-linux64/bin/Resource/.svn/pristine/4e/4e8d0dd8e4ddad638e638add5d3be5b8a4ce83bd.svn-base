// 这个着色器适合像文字、地标这样固定像素大小的物体

attribute vec4 vertex;
attribute vec3 normal;
attribute vec4 uv0;
attribute vec4 uv1;

uniform mat4 worldview_matrix;
uniform mat4 projection_matrix;
uniform mat4 inverse_projection_matrix;
uniform mat4 texture0_matrix;
uniform mat4 texture1_matrix;
uniform vec4 viewport_size;

varying vec4 texCoord;
varying vec2 tex1Coord;

float computerOnePixelLength()
{
	// 计算投影后的坐标
	vec4 viewPos = worldview_matrix * vertex;
	vec4 winPos = projection_matrix * viewPos;
	
	// 偏移一个像素
	winPos.x -= 2.0 * viewport_size.z * winPos.w;
	
	// 变换回视觉坐标系
	vec4 newViewPos = inverse_projection_matrix * winPos;
	
	// 视觉坐标系中的偏差
	return length(viewPos - newViewPos);
}

void main()
{
	// 计算纹理坐标
	texCoord = texture0_matrix * uv0;
	tex1Coord = vec2(texture1_matrix * uv1);

	// 计算顶点坐标值
	vec4 viewPos = worldview_matrix * vertex;
	viewPos.xyz += normal * computerOnePixelLength();
	// 向相机拉近一些
	viewPos.xyz *= 0.9;
	gl_Position = projection_matrix * viewPos;
}
