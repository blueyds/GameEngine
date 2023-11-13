//
//  VertexDescriptorLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit


public class VertexDescriptorLibrary {


	private var vertexDescriptors: [ String: VertexDescriptor] = [:]
	public init () {
		createDefaultVertexDescriptors()
	}
	private func createDefaultVertexDescriptors(){
		createBasic()
	}
	public func add(vertexDescriptor: VertexDescriptor, named name: String){
		vertexDescriptors.updateValue(vertexDescriptor, forKey: name)	}
	public subscript(name: String) -> MTLVertexDescriptor? {
		vertexDescriptors[name]?.vertexDescriptor
	}
	private func createBasic(){
//		let basic = VertexDescriptor(name: "Basic Vertex Descriptor")
//		// position attributes
//		basic.addAttribute(position: 0, format: .float3, offset: 0, bufferIndex: 0)
//		// color attributes
//		basic.addAttribute(position: 1, format: .float4, offset: simd_float3.size, bufferIndex: 0)
//		// texture attribures
//		basic.addAttribute(position: 2, format: .float2, offset: simd_float3.size + simd_float4.size, bufferIndex: 0)
//		// normal attributes
//		basic.addAttribute(position: 3, format: .float3, offset: simd_float3.size + simd_float4.size + simd_float2.size, bufferIndex: 0)
//		// layout
//		basic.addLayout(stride: Vertex.stride)
//		add(vertexDescriptor: basic)
	}
}

public class VertexDescriptor {
//	var name: String
	var vertexDescriptor: MTLVertexDescriptor
	public struct Attribute {
		public var position: Int
		public var format: MTLVertexFormat
		public var offset: Int
		public var bufferIndex: Int
		public init(position: Int, format: MTLVertexFormat, offset: Int, bufferIndex: Int){
			self.position = position
			self.format = format
			self.offset = offset
			self.bufferIndex = bufferIndex
		}
	}
	public struct Layout {
		public var stride: Int
		public var stepFunction: MTLVertexStepFunction
		public var stepRate: Int
		public init(stride: Int, stepFunction: MTLVertexStepFunction = .perVertex, stepRate: Int = 1) {
			self.stride = stride
			self.stepFunction = stepFunction
			self.stepRate = stepRate
		}
	}

	public init ( vertexDescriptor: MTLVertexDescriptor){
		self.vertexDescriptor = vertexDescriptor
	}

	public init (){
		vertexDescriptor = MTLVertexDescriptor()
	}
	public init( attributes: [Attribute], layouts: [Layout]){
		vertexDescriptor = MTLVertexDescriptor()
		attributes.forEach(){
			addAttribute(position: $0.position, format: $0.format, offset: $0.offset, bufferIndex: $0.bufferIndex)
		}
		layouts.forEach(){
			addLayout(stride: $0.stride, stepFunction: $0.stepFunction, stepRate: $0.stepRate)
		}

	}
	public func addAttribute(position: Int, format: MTLVertexFormat, offset: Int, bufferIndex: Int){
		
		vertexDescriptor.attributes[position].format = format
		vertexDescriptor.attributes[position].offset = offset
		vertexDescriptor.attributes[position].bufferIndex = bufferIndex
	}
	public func addLayout(stride: Int, stepFunction: MTLVertexStepFunction = .perVertex, stepRate: Int = 1){
		vertexDescriptor.layouts[0].stride = stride
		vertexDescriptor.layouts[0].stepFunction = stepFunction
		vertexDescriptor.layouts[0].stepRate = stepRate
	}
}
