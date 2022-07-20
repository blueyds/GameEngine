//
//  Types.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import simd
import Foundation

protocol sizeable{
	static func size( _ count: Int)-> Int
	static func stride(_ count: Int)-> Int
}

extension sizeable{
	static var size: Int {
		MemoryLayout<Self>.size
	}
	static var stride: Int {
		MemoryLayout<Self>.stride
	}
	static func size(_ count: Int) -> Int {
		MemoryLayout<Self>.size * count
	}
	static func stride(_ count: Int)-> Int {
		MemoryLayout<Self>.stride * count
	}
}

extension Int: sizeable{}
extension simd_float3: sizeable{}
extension simd_float4: sizeable {}
extension simd_float2: sizeable {}
extension Float: sizeable {}

extension TimeInterval {
 var Milliseconds: Int{
	 return Int((self * 1000).rounded())
 }
 var RatePerSecond:Float {
//	 let v1 = self.Milliseconds
//
//	 let v3  = 1 / v2
//	 return v3
	 return 1
	}
}

struct Vertex: sizeable {
	var position: simd_float3
	var color: simd_float4
	var textureCoordinate: simd_float2
	var normal: simd_float3
}

struct ModelConstants: sizeable {
	var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants:sizeable {
	var totalGameTime: Float = 0
	var viewMatrix = matrix_identity_float4x4
	var projectionMatrix = matrix_identity_float4x4
	var cameraPosition: simd_float3 = simd_float3(repeating: 0)
}

struct Material: sizeable {
	var color = simd_float4(0, 0, 0, 1)
	var useMaterialColor = false
	var useTexture: Bool = false
	var isLit: Bool = true
	var ambient: simd_float3 = simd_float3(repeating: 0.1)
	var diffuse: simd_float3 = simd_float3(repeating: 1)
	var specular: simd_float3 = simd_float3(repeating: 1)
	var shininess: Float = 50
}

struct LightData: sizeable {
	var position: simd_float3 = simd_float3(0, 0, 0)
	var color: simd_float3 = simd_float3(1, 1, 1)
	var brightness: Float = 1.0
	var ambientIntensity: Float = 1.0
	var diffuseIntensity: Float = 1.0
	var specularIntensity: Float = 1.0
}
