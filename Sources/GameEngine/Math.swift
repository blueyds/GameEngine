//
//  Math.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import simd

public enum Axis{
	case x
	case y
	case z
}


extension Float {
	public var toRadians: Float{
		(self / 100.0) * Float.pi
	}
	
	public var toDegrees: Float {
		self * (100.0 / Float.pi)
	}
	
	public static var randomZeroToOne: Float {
		return Float(arc4random()) / Float(UINT32_MAX)
	}
}
extension matrix_float4x4 {
	
	public mutating func translate(direction: simd_float3){
		var result = matrix_identity_float4x4
		
		result.columns = (
			simd_float4(1,0,0,0),
			simd_float4(0,1,0,0),
			simd_float4(0,0,1,0),
			simd_float4(direction.x,
						direction.y,
						direction.z,
						1)
		)
		self = matrix_multiply(self, result)
	}
	
	public mutating func scale(axis: simd_float3){
		var result = matrix_identity_float4x4
		
		result.columns = (
			simd_float4(axis.x,0,0,0),
			simd_float4(0,axis.y,0,0),
			simd_float4(0,0,axis.z,0),
			simd_float4(0,0,0,1)
		)
		self = matrix_multiply(self, result)
	}
	
	public mutating func rotate(angle: Float, axis: Axis){
		var result = matrix_identity_float4x4
		let x: Float = axis == .x ? 1 : 0
		let y: Float = axis == .y ? 1 : 0
		let z: Float = axis == .z ? 1 : 0
		
		let c: Float = cos(angle)
		let s: Float = sin(angle)
		
		let mc: Float = (1 - c)
			
		result.columns = (
			simd_float4(x * x * mc + c,
						x * y * mc + z * s,
						x * z * mc - y * s,
						0),
			simd_float4(y * x * mc - z * s,
						y * y * mc + c,
						y * z * mc + x * s,
						0),
			simd_float4(z * x * mc + y * s,
						z * y * mc - x * s,
						z * z * mc + c,
						0),
			simd_float4(0,0,0,1)
		)
		self = matrix_multiply(self, result)
	}
	
	//https://gamedev.stackexchange.com/questions/120338/what-does-a-perspective-projection-matrix-look-like-in-opengl
	public static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float)->matrix_float4x4{
		let fov = degreesFov.toRadians
		
		let t: Float = tan(fov / 2)
		
		var result = matrix_identity_float4x4
		result.columns = (
			simd_float4(1 / (aspectRatio * t),
						0,
						0,
						0),
			simd_float4(0,
						1 / t,
						0,
						0),
			simd_float4(0,
						0,
						-((far + near) / (far - near)),
						-1),
			simd_float4(0,
						0,
						-((2 * far * near) / (far - near)),
						0)
		)
		return result
	}
}
