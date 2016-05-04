//---------------------------------------------------------------------------
//These materials/shaders are part of the NEW InstanceManager implementation
//Written by Matias N. Goldberg ("dark_sylinc")
//---------------------------------------------------------------------------
//#version 120

//Parameters
uniform sampler2D selectionTexture;

attribute vec4 vertex;
attribute vec3 normal;
attribute vec4 colour;
attribute vec4 uv0;
attribute vec4 uv1;
attribute vec4 uv2;
attribute vec4 uv3;
attribute vec4 uv4;
attribute vec4 secondary_colour;

varying vec4 texCoord;
varying vec4 clip_vertex;

void DirectionalLight(in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	vec3 ecPosition = vec3(gl_ModelViewMatrix * vertex);

	// 计算从表面点到摄像机的向量
	//vec3 eye = vec3(normalize(cameraPos-ecPosition));
	vec3 eye = -normalize(ecPosition);
	vec3 vp = normalize(vec3(gl_LightSource[0].position));
	// 计算视线与光线的半向量
	vec3 halfVector = normalize(vp+eye);
	
	float nDotVP = max(0.0, dot(normal, vp));
	float nDotHV = dot(normal, halfVector);

	// 粗糙度，越小越光滑
	float shininess = 50.0;//gl_FrontMaterial.shininess;
	// 镜面反射光强度因子
	float powerFactor = max(0.0, pow(nDotHV, shininess));

	ambient += gl_LightSource[0].ambient;
	diffuse += gl_LightSource[0].diffuse * nDotVP;
	specular += gl_LightSource[0].specular * powerFactor;
}

void main(void)
{
	mat4 worldMatrix;
	worldMatrix[0] = uv1;
	worldMatrix[1] = uv2;
	worldMatrix[2] = uv3;
	worldMatrix[3] = vec4( 0, 0, 0, 1 );

	texCoord = gl_TextureMatrix[0] * uv0;
	
	vec4 worldPos		= vertex * worldMatrix;
	//Transform the position
	gl_Position = gl_ModelViewProjectionMatrix * worldPos;
	gl_ClipVertex = gl_ModelViewMatrix * worldPos;
	clip_vertex = gl_ClipVertex;

	// 计算定向光各通道强度
	vec4 ambientTemp = vec4(0.0);
	vec4 diffuseTemp = vec4(0.0);
	vec4 specularTemp = vec4(0.0);
	
	vec3 newNormal = vec3(gl_NormalMatrix * normal);
	newNormal = normalize(newNormal);
	newNormal = newNormal * gl_NormalScale;
 
	DirectionalLight(newNormal, ambientTemp, diffuseTemp, specularTemp);
	gl_FrontColor = (gl_LightModel.ambient + diffuseTemp) * uv4 * gl_Color;
}
