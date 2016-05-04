attribute vec4 vertex;
uniform mat4 worldview_matrix;
uniform mat4 projection_matrix;
uniform mat4 renderTextureMatrix;

varying vec4 renderTextureCoord;
varying vec4 viewPos;

void main()
{
	// ����ƹ�ռ��µĶ���λ��
	// ֱ�������������ᵼ�¾�����ʧ������ֵ̫����float��ȡ��; 
	// ͨ�������Ӿ����꣬�����������õľ�����ˣ�������ɫ���г���̫���ֵ
	viewPos = worldview_matrix * gl_Vertex;
	renderTextureCoord = renderTextureMatrix * viewPos;
	
	// project position to the screen
	gl_Position = projection_matrix * viewPos;
}
