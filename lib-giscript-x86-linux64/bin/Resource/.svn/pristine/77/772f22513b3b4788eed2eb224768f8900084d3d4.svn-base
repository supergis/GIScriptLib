
uniform mat4 texWorldViewProjMatrix0;
uniform mat4 texWorldViewProjMatrix1;
uniform mat4 texWorldViewProjMatrix2;

varying vec4 shadowmapTexCoord0;
varying vec4 shadowmapTexCoord1;
varying vec4 shadowmapTexCoord2;
varying float cameraDepth;

void main()
{
	// 计算灯光空间下的顶点位置
	shadowmapTexCoord0 = texWorldViewProjMatrix0 * gl_Vertex;
	shadowmapTexCoord1 = texWorldViewProjMatrix1 * gl_Vertex;
	shadowmapTexCoord2 = texWorldViewProjMatrix2 * gl_Vertex;

	// 投影到屏幕上的位置
	gl_Position = ftransform();
	// 传递相机深度
	cameraDepth = gl_Position.z;
	
	gl_ClipVertex = gl_ModelViewMatrix * gl_Vertex;
}
