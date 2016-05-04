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
	// ����ƹ�ռ��µĶ���λ��
	shadowmapTexCoord0 = texture0_worldviewproj_matrix * vertex;
	shadowmapTexCoord1 = texture1_worldviewproj_matrix * vertex;
	shadowmapTexCoord2 = texture2_worldviewproj_matrix * vertex;

	// �������Ӿ�����ϵ�е�����ֵ
	vec4 viewPos = worldview_matrix * vertex;
	// ������Ļ����
	windowPos = projection_matrix * viewPos;
	cameraDepth = windowPos.z;
	
	// ����ƫ�ƺ��λ��
	viewPos.xyz += normal;
	gl_Position = projection_matrix * viewPos;
}
