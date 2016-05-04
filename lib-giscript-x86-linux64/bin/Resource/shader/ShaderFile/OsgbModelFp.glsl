#include <lib/ClipPlane.glsllib>

uniform sampler2D diffuseTexture;

#if ADDTEX
uniform sampler3D volumeTexture;
#endif

void main()
{
	vec4 color = texture2D(diffuseTexture, gl_TexCoord[0].xy);
	
	if(color.a < 0.1)
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

	gl_FragColor = color;

#if ADDTEX
	vec4 volumeColor = texture3D(volumeTexture, gl_TexCoord[1].xyz);
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb * volumeColor.rgb;
#else
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb;
#endif
}
