#if GL_ES
	precision mediump float;
#endif

uniform vec4 surface_diffuse_colour;

void main()
{
	gl_FragColor = surface_diffuse_colour;
}