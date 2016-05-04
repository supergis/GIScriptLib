#include <lib/ClipPlane.glsllib>

varying vec4 vec4SelectionColor;

void main()
{
	if(vec4SelectionColor.a < 0.1 || gl_Color.a < 0.1)
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

	gl_FragColor = gl_Color * vec4SelectionColor;
}
