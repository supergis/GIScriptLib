#include <lib/ClipPlane.glsllib>

uniform sampler2D diffuseTexture;

#if ADDTEX
uniform sampler3D volumeTexture;
#endif

varying vec4 vec4SelectionColor;

varying float fTexCoordTranslate[2];
varying float fTexCoordScale;
varying float fTexTileWidth;
varying float fMaxMipLev;

void CalculateMipLevel(in vec2 inTexCoord, in float vecTile, in float fMaxMip, inout float mipLevel)
{		
	// ���� Mipmap ͼ��
	vec2 dx = dFdx(inTexCoord * vecTile);
 	vec2 dy = dFdy(inTexCoord * vecTile);

	float dotX = dot(dx, dx);
	float dotY = dot(dy, dy);
 	float dMax = max(dotX, dotY);
 	float dMin = min(dotX, dotY);
 	float offset = (dMax - dMin) / (dMax + dMin);
 	offset = clamp(offset, 0.0, 1.0);
 	float d = dMax * (1.0 - offset) + dMin * offset;

 	mipLevel = 0.5 * log2(d);
	mipLevel = clamp(mipLevel, 0.0, fMaxMip - 1.62);
}

void CalculateTexCoord(in vec2 inTexCoord, in float scale, in float XTran, in float YTran, in float fTile, in float mipLevel, inout vec2 outTexCoord)
{
	vec2 fTexCoord = fract(inTexCoord);
	
	float fOffset = 1.0 * pow(2.0, mipLevel)/ fTile;
	
	fTexCoord = clamp(fTexCoord, 0.0 + fOffset, 1.0 - fOffset);

	outTexCoord.x = (fTexCoord.x + XTran) * scale;
	outTexCoord.y = (fTexCoord.y + YTran) * scale;
}

void main()
{
	vec2 vecTexCoord;
	float mipLevel = 0.0;
	
	CalculateMipLevel(gl_TexCoord[0].xy, fTexTileWidth, fMaxMipLev, mipLevel);
	CalculateTexCoord(gl_TexCoord[0].xy, fTexCoordScale, fTexCoordTranslate[0], fTexCoordTranslate[1], fTexTileWidth, mipLevel, vecTexCoord);
	
	vec4 color = texture2DLod(diffuseTexture, vecTexCoord, mipLevel);
	
	if(vec4SelectionColor.a < 0.1 || color.a < 0.1)
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

#if ADDTEX
	vec4 volumeColor = texture3D(volumeTexture, gl_TexCoord[1].xyz);
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb * volumeColor.rgb;
#else
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb;
#endif

}
