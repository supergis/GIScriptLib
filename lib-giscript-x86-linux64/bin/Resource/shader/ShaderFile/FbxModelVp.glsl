uniform int hasSelection;
uniform sampler2D selectionTexture;

varying vec4 vec4SelectionColor;  // 选中颜色
varying vec4 clip_vertex;

void DirectionalLight(in vec3 normal, inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
	vec3 ecPosition = vec3(gl_ModelViewMatrix * gl_Vertex);

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
	vec4 vertexPos = gl_Vertex;

	// 计算定向光各通道强度
	vec4 ambientTemp = vec4(0.0);
	vec4 diffuseTemp = vec4(0.0);
	vec4 specularTemp = vec4(0.0);

	vec3 newNormal = vec3(gl_NormalMatrix*gl_Normal);
	newNormal = normalize(newNormal);
        newNormal = newNormal * gl_NormalScale;
	
	DirectionalLight(newNormal, ambientTemp, diffuseTemp, specularTemp);
	vec4 mixColor = gl_FrontLightModelProduct.sceneColor
		+ ambientTemp*gl_FrontMaterial.ambient
		+ diffuseTemp*gl_FrontMaterial.diffuse
		+ specularTemp*gl_FrontMaterial.specular;
	
	mixColor = clamp(mixColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0));
	gl_FrontColor = mixColor;

	vec4SelectionColor = vec4(1.0, 1.0, 1.0, 1.0);

	if(hasSelection == 1 && vec4SelectionColor.a > 0.0 && gl_SecondaryColor.r < 0.99 && gl_SecondaryColor.g < 0.99 && gl_SecondaryColor.b < 0.99 && gl_SecondaryColor.a < 0.99)
	{
		vec4 selColor = texture2D(selectionTexture, vec2(0.5, 0.5));
		float r = abs(gl_SecondaryColor.r - selColor.r);
		float g = abs(gl_SecondaryColor.g - selColor.g);
		float b = abs(gl_SecondaryColor.b - selColor.b);
		float a = abs(gl_SecondaryColor.a - selColor.a);

		if(r < 0.003 && g < 0.003 && b < 0.003 && a < 0.003)
		{
			vec4SelectionColor = vec4(0.7,0.6,0.8,1.0);
		}
	}
	
	vec4SelectionColor = vec4SelectionColor * gl_Color;
	
	gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	gl_TexCoord[1] = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	gl_Position = gl_ModelViewProjectionMatrix * vertexPos;
	gl_ClipVertex = gl_ModelViewMatrix * gl_Vertex;
	clip_vertex = gl_ClipVertex;
}
