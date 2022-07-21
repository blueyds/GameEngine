import MetalKit

public class Quad_CustomMesh: CustomMesh {
	public override func createVertices() {
		addVertex(position: simd_float3(1,1,0), 	color: simd_float4(1,0,0,1),	textureCoordinates: simd_float2(1,0)) // TR
		addVertex(position: simd_float3(-1,1,0), 	color: simd_float4(0,1,0,1),	textureCoordinates: simd_float2(0,0)) //TL
		addVertex(position: simd_float3(-1,-1,0), 	color: simd_float4(0,0,1,1),	textureCoordinates: simd_float2(0,1)) //BL
	
		addVertex(position: simd_float3(1,1,0), 	color: simd_float4(1,0,0,1),	textureCoordinates: simd_float2(1,0)) //TR
		addVertex(position: simd_float3(-1,-1,0), 	color: simd_float4(0,1,0,1),	textureCoordinates: simd_float2(0,1)) //TL
		addVertex(position: simd_float3(1,-1,0), 	color: simd_float4(0,0,1,1),	textureCoordinates: simd_float2(1,1)) //B
	}
}
