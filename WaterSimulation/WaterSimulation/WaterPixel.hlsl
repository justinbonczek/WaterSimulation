struct VertexToPixel
{
	float4 position		: SV_POSITION;
	float4 color		: COLOR;
	float2 uv			: TEXCOORD0;
	float3 normal		: NORMAL;
	float3 tangent		: TANGENT;
};

Texture2D _Texture : register(t0);
SamplerState _Sampler : register(s0);

float4 main(VertexToPixel input) : SV_TARGET
{
	return float4(_Texture.Sample(_Sampler, input.uv * 5).rgb, 0.6);
	//return input.color;
}