#include <lib/ClipPlane.glsllib>

#if ADDTEX
uniform sampler3D volumeTexture;
#endif

void main()
{	
	if(gl_Color.a < 0.1)
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

#if ADDTEX
	vec4 volumeColor = texture3D(volumeTexture, gl_TexCoord[0].xyz);
	gl_FragColor = gl_Color * volumeColor;
#else
	gl_FragColor = gl_Color;
#endif
}
