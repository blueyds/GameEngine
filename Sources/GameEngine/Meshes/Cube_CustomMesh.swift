import MetalKit

public class Cube_CustomMesh: CustomMesh {
	public override func createVertices() {
		//Left
		addVertex(position: float3(-1.0,-1.0,-1.0))
		addVertex(position: float3(-1.0,-1.0, 1.0))
		addVertex(position: float3(-1.0, 1.0, 1.0))
		addVertex(position: float3(-1.0,-1.0,-1.0))
		addVertex(position: float3(-1.0, 1.0, 1.0))
		addVertex(position: float3(-1.0, 1.0,-1.0))
		
		//RIGHT
		addVertex(position: float3( 1.0, 1.0, 1.0))
		addVertex(position: float3( 1.0,-1.0,-1.0))
		addVertex(position: float3( 1.0, 1.0,-1.0))
		addVertex(position: float3( 1.0,-1.0,-1.0))
		addVertex(position: float3( 1.0, 1.0, 1.0))
		addVertex(position: float3( 1.0,-1.0, 1.0))
		
		//TOP
		addVertex(position: float3( 1.0, 1.0, 1.0))
		addVertex(position: float3( 1.0, 1.0,-1.0))
		addVertex(position: float3(-1.0, 1.0,-1.0))
		addVertex(position: float3( 1.0, 1.0, 1.0))
		addVertex(position: float3(-1.0, 1.0,-1.0))
		addVertex(position: float3(-1.0, 1.0, 1.0))
		
		//BOTTOM
		addVertex(position: float3( 1.0,-1.0, 1.0))
		addVertex(position: float3(-1.0,-1.0,-1.0))
		addVertex(position: float3( 1.0,-1.0,-1.0))
		addVertex(position: float3( 1.0,-1.0, 1.0))
		addVertex(position: float3(-1.0,-1.0, 1.0))
		addVertex(position: float3(-1.0,-1.0,-1.0))
		
		//BACK
		addVertex(position: float3( 1.0, 1.0,-1.0))
		addVertex(position: float3(-1.0,-1.0,-1.0))
		addVertex(position: float3(-1.0, 1.0,-1.0))
		addVertex(position: float3( 1.0, 1.0,-1.0))
		addVertex(position: float3( 1.0,-1.0,-1.0))
		addVertex(position: float3(-1.0,-1.0,-1.0))
		
		//FRONT
		addVertex(position: float3(-1.0, 1.0, 1.0))
		addVertex(position: float3(-1.0,-1.0, 1.0))
		addVertex(position: float3( 1.0,-1.0, 1.0))
		addVertex(position: float3( 1.0, 1.0, 1.0))
		addVertex(position: float3(-1.0, 1.0, 1.0))
		addVertex(position: float3( 1.0,-1.0, 1.0))
	}

}
