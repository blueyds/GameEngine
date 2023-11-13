import MetalKit

public class Triangle_CustomMesh: CustomMesh {
	public override func createVertices() {
		addVertex(position: simd_float3(0,1,0))
		addVertex(position: simd_float3(-1,-1,0))
		addVertex(position: simd_float3(1,-1,0))
	}
}
