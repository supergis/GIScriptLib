
uniform int hasEvevation;
uniform sampler2D elevationTexture;
uniform vec4 v4RectPos;
uniform float fTransparent;

varying vec4 vecVertexColor;
varying vec4 clip_vertex;

vec4 CalculateHeight()
{
	vec2 vecRatio = vec2(v4RectPos.z - v4RectPos.x, v4RectPos.w - v4RectPos.y);
	vec2 texCoord = vec2(gl_Vertex.x - v4RectPos.x, gl_Vertex.y - v4RectPos.y);
	vec4 vecPos = gl_Vertex;
	
	texCoord.x = texCoord.x / vecRatio.x;
	texCoord.y = 1.0 - texCoord.y / vecRatio.y;
	
	if(texCoord.x > 1.0 || texCoord.x < 0.0 || texCoord.y > 1.0 || texCoord.y < 0.0)
	{
		return vecPos;
	}
	
	float height = texture2DLod(elevationTexture,texCoord.xy, 0.0).x;
	
	if(gl_Vertex.z < height)
	{
		vecPos.z = gl_Vertex.z;
	}
	else
	{
		vecPos.z = height;
	}
	
	return vecPos;
}

void main(void)
{
	vec4 vertexPos = gl_Vertex;
	
	if(hasEvevation == 1)
	{
		vertexPos = CalculateHeight();
	}

	vecVertexColor = vec4(0.0, 0.0, 0.0, 0.0);
	if(gl_Color.a > fTransparent)
	{
		vecVertexColor = gl_SecondaryColor;
	}
	gl_Position = gl_ModelViewProjectionMatrix * vertexPos;
	clip_vertex = gl_ModelViewMatrix * vertexPos;
}
