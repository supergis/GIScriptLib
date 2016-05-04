#include <lib/ClipPlane.glsllib>

uniform sampler2D diffuseTexture;

varying vec4 vec4SelectionColor;

void main()
{
	vec4 color = texture2D(diffuseTexture, gl_TexCoord[0].xy);
	
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
	
	gl_FragColor = color * vec4SelectionColor;
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb;
}
