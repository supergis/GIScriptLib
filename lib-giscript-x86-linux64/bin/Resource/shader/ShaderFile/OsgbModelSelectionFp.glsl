#include <lib/ClipPlane.glsllib>

varying vec4 vecVertexColor;

void main()
{
	if(vecVertexColor.a < 0.001)
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
	
	gl_FragColor = vecVertexColor;
}
