#if GL_ES
	precision mediump float;
#endif

#include <lib/ClipPlane.glsllib>

uniform sampler2D texture0;

varying vec4 texCoord;

void main()
{
	vec4 color = gl_Color * texture2D(texture0, texCoord.xy);
	if (color.a < 0.1)
	{
		discard;
		return;
	}

#if CLIP
	if(!Clip())
	{
		discard;
		return;
	}
#endif
	gl_FragColor = color;
}