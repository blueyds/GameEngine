//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 12/3/22.
//

import Foundation
import simd



public struct LightData: sizeable {
	public var position: simd_float3 = simd_float3(0, 0, 0)
	public var color: simd_float3 = simd_float3(1, 1, 1)
	public var brightness: Float = 1.0
	public var ambientIntensity: Float = 1.0
	public var diffuseIntensity: Float = 1.0
	public var specularIntensity: Float = 1.0
	init(){
		self.position = simd_float3(repeating: 0)
		self.color = simd_float3(repeating: 1)
		self.brightness = 1.0
		self.ambientIntensity = 1.0
		self.diffuseIntensity = 1.0
		self.specularIntensity = 1.0
	}
}

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
