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

public typealias Matrix = matrix_float4x4

extension Matrix {
	public static var identity: Matrix {
        matrix_identity_float4x4
	}
	public mutating func translate(direction: Float3){
		var result = Matrix.identity
		
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
	
	public mutating func scale(axis: Float3){
		var result = Matrix.identity
		
		result.columns = (
			simd_float4(axis.x,0,0,0),
			simd_float4(0,axis.y,0,0),
			simd_float4(0,0,axis.z,0),
			simd_float4(0,0,0,1)
		)
		self = matrix_multiply(self, result)
	}
	
	public mutating func rotate(angle: Float, axis: Axis){
		var result = Matrix.identity
		let x: Float = axis == .x ? 1 : 0
		let y: Float = axis == .y ? 1 : 0
		let z: Float = axis == .z ? 1 : 0
		
		let c: Float = cos(angle)
		let s: Float = sin(angle)
		
		let mc: Float = (1 - c)
			
		result.columns = (
			Float4(x * x * mc + c,
				x * y * mc + z * s,
				x * z * mc - y * s,
				0),
			Float4(y * x * mc - z * s,
				y * y * mc + c,
				y * z * mc + x * s,
				0),
			Float4(z * x * mc + y * s,
				z * y * mc - x * s,
				z * z * mc + c,
				0),
			Float4(0,0,0,1)
		)
		self = matrix_multiply(self, result)
	}
	
	//https://gamedev.stackexchange.com/questions/120338/what-does-a-perspective-projection-matrix-look-like-in-opengl
	public static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float)->Matrix{
		let fov = degreesFov.toRadians
		
		let t: Float = tan(fov / 2)
		
		var result = Matrix.identity
		result.columns = (
			Float4(1 / (aspectRatio * t),
				0,
				0,
				0),
			Float4(0,
				1 / t,
				0,
				0),
			Float4(0,
				0,
				-((far + near) / (far - near)),
				-1),
			Float4(0,
				0,
				-((2 * far * near) / (far - near)),
				0)
		)
		return result
	}
}