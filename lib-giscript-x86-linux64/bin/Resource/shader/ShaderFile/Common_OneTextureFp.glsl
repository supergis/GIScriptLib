#if GL_ES
	precision mediump float;
#endif

uniform sampler2D texture0;
uniform vec4 surface_diffuse_colour;

varying vec4 texCoord;

void main()
{
	vec4 color = surface_diffuse_colour * texture2D(texture0, texCoord.xy);
	if (color.a < 0.2)
	{
		discard;
		return;
	}
	gl_FragColor = color;
}