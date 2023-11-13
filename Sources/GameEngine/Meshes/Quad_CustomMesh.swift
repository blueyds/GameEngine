import MetalKit

public class Quad_CustomMesh: CustomMesh {
	public override func createVertices() {
		addVertex(position: float3(1,1,0), textureCoordinates: float2(1,0))
		addVertex(position: float3(-1,1,0), textureCoordinates: float2(0,0))
		addVertex(position: float3(-1,-1,0),textureCoordinates: float2(0,1))
		addVertex(position: float3(1,1,0), textureCoordinates: float2(1,0))
		addVertex(position: float3(-1,-1,0),textureCoordinates: float2(0,1))
		addVertex(position: float3(1,-1,0), textureCoordinates: float2(1,1))
	}
}
