import MetalKit

public class Cube_CustomMesh: CustomMesh {
	override func createVertices() {
		//Left
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.5, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
		
		//RIGHT
		addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.5, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 0.5, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
		
		//TOP
		addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.5, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
		
		//BOTTOM
		addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
		
		//BACK
		addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(0.5, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0,-1.0), color: simd_float4(0.0, 0.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0,-1.0), color: simd_float4(1.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0,-1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0,-1.0), color: simd_float4(1.0, 0.5, 1.0, 1.0))
		
		//FRONT
		addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(1.0, 0.5, 0.0, 1.0))
		addVertex(position: simd_float3(-1.0,-1.0, 1.0), color: simd_float4(0.0, 1.0, 0.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(0.5, 0.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0, 1.0, 1.0), color: simd_float4(1.0, 1.0, 0.5, 1.0))
		addVertex(position: simd_float3(-1.0, 1.0, 1.0), color: simd_float4(0.0, 1.0, 1.0, 1.0))
		addVertex(position: simd_float3( 1.0,-1.0, 1.0), color: simd_float4(1.0, 0.0, 1.0, 1.0))
	}

}
