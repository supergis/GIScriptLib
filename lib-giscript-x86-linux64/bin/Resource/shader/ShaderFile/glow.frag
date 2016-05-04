void main()
{
	gl_FragColor = vec4(0.6,0.6,1.0,1.0);
	gl_FragColor.a = pow( gl_TexCoord[0].x, 6.0 );
}