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


// Position extensions
extension simd_float3 {
	public func moveX(_ delta: Float){ self.x += delta }
	public func moveY(_ delta: Float){ self.y += delta }
	public func moveZ(_ delta: Float){ self.z += delta }	
}
// Rotation extensions
extension simd_float3 {
	public func rotateX(by delta: Float){ self.x += delta }
	public func rotateY(by delta: Float){ self.y += delta }
	public func rotateZ(by delta: Float){ self.z += delta }
}
// Scale extensions
extension simd_float3 {
	public func scaleX(by delta: Float){ self.x += delta }
	public func scaleY(by delta: Float){ self.y += delta }
	public func scaleZ(by delta: Float){ self.z += delta }
}
// RGB extensions
extension simd_float3 {
	var r: Float { 
		get { self.x }
		set { self.x = newValue }
	}
	var g: Float {
		get { self.y }
		set {  self.y = newValue }
	}
	var b: Float {
		get { self.z }
		set { self.z = newValue }
	}
	init(r: Float, g: Float, b: Float){
		self.r = r
		self.g = g
		self.b = b
	}
}
// RGBA extensions
extension simd_float4 {
	var r: Float { 
		get { self.x }
		set { self.x = newValue }
	}
	var g: Float {
		get { self.y }
		set {  self.y = newValue }
	}
	var b: Float {
		get { self.z }
		set { self.z = newValue }
	}
	var a: Float {
		get { self.w }
		set { self.w = newValue }
	}
	init(r: Float, g: Float, b: Float, a: Float){
		self.r = r
		self.g = g
		self.b = b
		self.a = a
	}
}

public struct Vertex: sizeable {
	public var position: simd_float3
	public var color: simd_float4
	public var textureCoordinate: simd_float2
	public var normal: simd_float3
	public init(position: simd_float3,
				color: simd_float4,
				textureCoordinate: simd_float2,
				normal: simd_float3){
		self.position = position
		self.color = color
		self.textureCoordinate = textureCoordinate
		self.normal = normal
	}

}

public struct ModelConstants: sizeable {
	public var modelMatrix = matrix_identity_float4x4
	public init(){
		modelMatrix = matrix_identity_float4x4
	}
}

public struct SceneConstants:sizeable {
	public var totalGameTime: Float = 0
	public var viewMatrix = matrix_identity_float4x4
	public var projectionMatrix = matrix_identity_float4x4
	public var cameraPosition: simd_float3
	public init(){
		totalGameTime = 0
		viewMatrix = matrix_identity_float4x4
		projectionMatrix = matrix_identity_float4x4
		cameraPosition = simd_float3(repeating: 0)
	}
}



