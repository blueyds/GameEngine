//
//  VertexDescriptorLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit


class VertexDescriptorLibrary {
	enum Types {
		case Basic
	}

	private var vertexDescriptors: [Types: VertexDescriptor] = [:]
	init () {
		createDefaultVertexDescriptors()
	}
	private func createDefaultVertexDescriptors(){
		createBasic()
	}
	func descriptor(_ vertexDescriptorType: Types) -> MTLVertexDescriptor {
		vertexDescriptors[vertexDescriptorType]!.vertexDescriptor
	}
	private func createBasic(){
		let basic = VertexDescriptor(name: "Basic Vertex Descriptor")
		// position attributes
		basic.addAttribute(position: 0, format: .float3, offset: 0, bufferIndex: 0)
		// color attributes
		basic.addAttribute(position: 1, format: .float4, offset: simd_float3.size, bufferIndex: 0)
		// texture attribures
		basic.addAttribute(position: 2, format: .float2, offset: simd_float3.size + simd_float4.size, bufferIndex: 0)
		// normal attributes
		basic.addAttribute(position: 3, format: .float3, offset: simd_float3.size + simd_float4.size + simd_float2.size, bufferIndex: 0)
		// layout
		basic.addLayout(stride: Vertex.stride)
		vertexDescriptors.updateValue(basic, forKey: .Basic)
	}
}

class VertexDescriptor {
	var name: String
	var vertexDescriptor: MTLVertexDescriptor
	init ( name: String, vertexDescriptor: MTLVertexDescriptor){
		self.name = name
		self.vertexDescriptor = vertexDescriptor
	}
	init (name: String){
		self.name = name
		vertexDescriptor = MTLVertexDescriptor()
	}
	func addAttribute(position: Int, format: MTLVertexFormat, offset: Int, bufferIndex: Int){
		
		vertexDescriptor.attributes[position].format = format
		vertexDescriptor.attributes[position].offset = offset
		vertexDescriptor.attributes[position].bufferIndex = bufferIndex
	}
	func addLayout(stride: Int, stepFunction: MTLVertexStepFunction = .perVertex, stepRate: Int = 1){
		vertexDescriptor.layouts[0].stride = stride
		vertexDescriptor.layouts[0].stepFunction = stepFunction
		vertexDescriptor.layouts[0].stepRate = stepRate
	}
}
