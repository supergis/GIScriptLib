#if GL_ES
	precision mediump float;
#endif

uniform sampler2D texture0;
uniform sampler2D texture1;

uniform vec4 surface_diffuse_colour;
uniform vec4 surface_ambient_colour;

varying vec4 texCoord;
varying vec2 tex1Coord;

void main()
{
	vec4 texColor = vec4(surface_diffuse_colour.xyz, min(texture2D(texture0, texCoord.xy).a, surface_diffuse_colour.a));
	vec4 haloTexColor = vec4(surface_ambient_colour.xyz, min(texture2D(texture1, tex1Coord).a, surface_ambient_colour.a));
	if (texColor.a+haloTexColor.a < 0.2)
	{
		discard;
		return;
	}
	
	vec3 v3Color = mix(haloTexColor.rgb, texColor.rgb, texColor.a+0.2);
	gl_FragColor = vec4(v3Color, min(1.0, texColor.a+haloTexColor.a));
}
