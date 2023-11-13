import Foundation
import simd

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
extension float3: sizeable{}
extension float4: sizeable {}
extension float2: sizeable {}
extension Float: sizeable {}
extension matrix: sizeable {}

