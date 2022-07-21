//
//  Types.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import simd
import Foundation

public protocol sizeable{
	static func size( _ count: Int)-> Int
	static func stride(_ count: Int)-> Int
}

extension sizeable{
	public static var size: Int {
		MemoryLayout<Self>.size
	}
	public static var stride: Int {
		MemoryLayout<Self>.stride
	}
	public static func size(_ count: Int) -> Int {
		MemoryLayout<Self>.size * count
	}
	public static func stride(_ count: Int)-> Int {
		MemoryLayout<Self>.stride * count
	}
}

extension Int: sizeable{}
extension simd_float3: sizeable{}
extension simd_float4: sizeable {}
extension simd_float2: sizeable {}
extension Float: sizeable {}

extension TimeInterval {
 public var Milliseconds: Int{
	 return Int((self * 1000).rounded())
 }
 public var RatePerSecond:Float {
//	 let v1 = self.Milliseconds
//
//	 let v3  = 1 / v2
//	 return v3
	 return 1
	}
}

public struct Vertex: sizeable {
	public var position: simd_float3
	public var color: simd_float4
	public var textureCoordinate: simd_float2
	public var normal: simd_float3
}

public struct ModelConstants: sizeable {
	public var modelMatrix = matrix_identity_float4x4
}

public struct SceneConstants:sizeable {
	public var totalGameTime: Float = 0
	public var viewMatrix = matrix_identity_float4x4
	public var projectionMatrix = matrix_identity_float4x4
	public var cameraPosition: simd_float3 = simd_float3(repeating: 0)
}

public struct Material: sizeable {
	public var color = simd_float4(0, 0, 0, 1)
	public var useMaterialColor = false
	public var useTexture: Bool = false
	public var isLit: Bool = true
	public var ambient: simd_float3 = simd_float3(repeating: 0.1)
	public var diffuse: simd_float3 = simd_float3(repeating: 1)
	public var specular: simd_float3 = simd_float3(repeating: 1)
	public var shininess: Float = 50
}

public struct LightData: sizeable {
	public var position: simd_float3 = simd_float3(0, 0, 0)
	public var color: simd_float3 = simd_float3(1, 1, 1)
	public var brightness: Float = 1.0
	public var ambientIntensity: Float = 1.0
	public var diffuseIntensity: Float = 1.0
	public var specularIntensity: Float = 1.0
}
