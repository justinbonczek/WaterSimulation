#ifndef WATER_H
#define WATER_H

#include "GameObject.h"

__declspec(align(16))
struct WaterBufferData
{
	float amp1;
	float amp2;
	float freq1;
	float freq2;
	float speed1;
	float speed2;
	float k;
};

class Water : public GameObject
{
public:
	Water(Mesh* mesh, Material* mat);
	virtual ~Water();

	void Update(float dt);
	void Draw(ID3D11DeviceContext* devCon);

	void SetupBuffer(ID3D11Device* dev);
private:
	ID3D11Buffer* waterBuffer;
	WaterBufferData waterBufferData;
};

#endif