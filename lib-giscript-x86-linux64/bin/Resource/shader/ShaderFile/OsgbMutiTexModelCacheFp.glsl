#include <lib/ClipPlane.glsllib>
uniform sampler2D diffuseTexture;
uniform sampler2D secondTexture;

#if ADDTEX
uniform sampler3D volumeTexture;
#endif
varying vec4 vec4SelectionColor;

varying float fTexCoordTranslate[4];
varying float fTexCoordScale[2];
varying float fTexTileWidth[2];
varying float fMaxMipLev[2];

void CalculateMipLevel(in vec2 inTexCoord, in float vecTile, in float fMaxMip, inout float mipLevel)
{		
	// º∆À„ Mipmap Õº≤„
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
	
	CalculateMipLevel(gl_TexCoord[0].xy, fTexTileWidth[0], fMaxMipLev[0], mipLevel);
	CalculateTexCoord(gl_TexCoord[0].xy, fTexCoordScale[0], fTexCoordTranslate[0], fTexCoordTranslate[1], fTexTileWidth[0], mipLevel, vecTexCoord);
	vec4 FColor = texture2DLod(diffuseTexture, vecTexCoord, mipLevel);
	
	CalculateMipLevel(gl_TexCoord[1].xy, fTexTileWidth[1], fMaxMipLev[1], mipLevel);
	CalculateTexCoord(gl_TexCoord[1].xy, fTexCoordScale[1], fTexCoordTranslate[2], fTexCoordTranslate[3], fTexTileWidth[1], mipLevel, vecTexCoord);
	vec4 SColor = texture2DLod(secondTexture, vecTexCoord, mipLevel);
	
	vec4 color = FColor * SColor;
	
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
	vec4 volumeColor = texture3D(volumeTexture, gl_TexCoord[2].xyz);
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb * volumeColor;
#else
	gl_FragColor.rgb = gl_FragColor.rgb * gl_Color.rgb;
#endif
}
