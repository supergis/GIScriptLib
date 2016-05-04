attribute vec4 vertex;
attribute vec3 normal;

uniform mat4 worldview_matrix;
uniform mat4 projection_matrix;
uniform mat4 texture0_worldviewproj_matrix;
uniform mat4 texture1_worldviewproj_matrix;
uniform mat4 texture2_worldviewproj_matrix;

varying vec4 shadowmapTexCoord0;
varying vec4 shadowmapTexCoord1;
varying vec4 shadowmapTexCoord2;
varying vec4 windowPos;
varying float cameraDepth;

void main()
{
	// 计算灯光空间下的顶点位置
	shadowmapTexCoord0 = texture0_worldviewproj_matrix * vertex;
	shadowmapTexCoord1 = texture1_worldviewproj_matrix * vertex;
	shadowmapTexCoord2 = texture2_worldviewproj_matrix * vertex;

	// 计算在视觉坐标系中的坐标值
	vec4 viewPos = worldview_matrix * vertex;
	// 传递屏幕坐标
	windowPos = projection_matrix * viewPos;
	cameraDepth = windowPos.z;
	
	// 计算偏移后的位置
	viewPos.xyz += normal;
	gl_Position = projection_matrix * viewPos;
}
