#include <lib/ClipPlane.glsllib>

uniform sampler2D diffuseTexture;
uniform sampler2D secondTexture;

varying vec4 vec4SelectionColor;

void main()
{
	vec4 firstColor = texture2D(diffuseTexture, gl_TexCoord[0].xy);
	vec4 secondColor = texture2D(secondTexture, gl_TexCoord[1].xy);
	
	if(vec4SelectionColor.a < 0.1)
	{
		discard;
	}

#if CLIP
	if(!Clip())
	{
		discard;
		return;
	}
#endif
	
	vec4 color = firstColor * secondColor;
	gl_FragColor = color * vec4SelectionColor;
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb;
}
