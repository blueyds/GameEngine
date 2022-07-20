import MetalKit

public class Triangle_CustomMesh: CustomMesh {
	override func createVertices() {
		addVertex(position: simd_float3(0,1,0), color: simd_float4(1,0,0,1))
		addVertex(position: simd_float3(-1,-1,0), color: simd_float4(0,1,0,1))
		addVertex(position: simd_float3(1,-1,0), color: simd_float4(0,0,1,1))
	}
}
