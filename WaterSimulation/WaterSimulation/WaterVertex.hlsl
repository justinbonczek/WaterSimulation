cbuffer perFrame : register(b0)
{
	matrix world;
	matrix view;
	matrix projection;
	float time;
};

cbuffer waterBuffer : register(b1)
{
	float amp1;
	float amp2;
	float freq1;
	float freq2;
	float speed1;
	float speed2;
};

struct VertexInput
{
	float3 position : POSITION;
	float4 color    : COLOR;
	float2 uv		: TEXCOORD0;
	float3 normal   : NORMAL;
	float4 tangent  : TANGENT;
};

struct VertexOutput
{
	float4 position : SV_POSITION;
	float4 color    : COLOR;
	float2 uv		: TEXCOORD0;
	float3 normal   : NORMAL;
	float3 tangent  : TANGENT;
	float3 bitangent: BITANGENT;
};

VertexOutput main(VertexInput input)
{
	VertexOutput o;

	matrix worldViewProj = mul(mul(world, view), projection);

	// Circular
	input.position.y = 2.0 * amp1 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq1 + time * speed1) / 2 + 1), 2.0) +
		2.0 * amp2 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq2 + time * speed2) / 2 + 1), 2.0) / 2.0;

	// Directional
	//input.position.y = 1.0 * pow(sin((dot(float2(-1.0, 0.0), float2(input.position.x, input.position.z)) * 1.0 + time * 1.3) / 2 + 1), 2.0) +
	//	2.0 * pow(sin((dot(float2(0.0, -1.0), float2(input.position.x, input.position.z)) * 1.0 + time * 2.0) / 2 + 1), 2.0);

	o.position = mul(float4(input.position, 1.0), worldViewProj);

	//o.tangent = normalize(float3(0.0, 1.0, ddy(2.0 * amp1 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq1 + time * speed1) / 2 + 1), 2.0) +
	//	2.0 * amp2 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq2 + time * speed2) / 2 + 1), 2.0) / 2.0)));
	//o.bitangent = normalize(float3(1.0, 0.0, ddx(2.0 * amp1 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq1 + time * speed1) / 2 + 1), 2.0) +
	//	2.0 * amp2 * pow(sin((dot(float2(0.0, 0.0) - float2(input.position.x, input.position.z), float2(input.position.x, input.position.z)) * freq2 + time * speed2) / 2 + 1), 2.0) / 2.0)));
	
	o.tangent = input.tangent;
	o.bitangent = cross(input.tangent, input.normal);
	o.normal = normalize(cross(o.bitangent, o.tangent));
	o.color = input.color;
	o.uv = input.uv;

	return o;
}