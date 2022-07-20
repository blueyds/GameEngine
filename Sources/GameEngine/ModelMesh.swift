//
//  ModelMesh.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/7/22.
//

import MetalKit

class ModelMesh: Mesh {
	
	
	private var _meshes: [Any]!
	var vertexCount: Int!
	
	
	init(modelName: String,
		 ext: String = "obj",
		 vertexDescriptor: MTLVertexDescriptor,
		 device: MTLDevice){
		loadModel(modelName: modelName,
				  ext: ext,
				  vertexDescriptor: vertexDescriptor,
				  device: device)
	}
	
	var instanceCount: Int = 1
	func setInstanceCount(_ count: Int) {
		instanceCount = count
	}
	
	private func loadModel(modelName:String,
						   ext: String,
						   vertexDescriptor: MTLVertexDescriptor,
						   device: MTLDevice){
		guard let assetUrl = Bundle.main.url(forResource: modelName, withExtension: ext) else {
			fatalError("Asset \(modelName) does not exist")
		}
		let descriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
		(descriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
		(descriptor.attributes[1] as! MDLVertexAttribute).name = MDLVertexAttributeColor
		(descriptor.attributes[2] as! MDLVertexAttribute).name = MDLVertexAttributeTextureCoordinate
		(descriptor.attributes[3] as! MDLVertexAttribute).name = MDLVertexAttributeNormal
		
		
		let bufferAllocator = MTKMeshBufferAllocator(device: device)
		let asset: MDLAsset = MDLAsset(url: assetUrl,
									   vertexDescriptor: descriptor,
									   bufferAllocator: bufferAllocator)
		do{
			self._meshes = try MTKMesh.newMeshes(asset: asset, device: device).metalKitMeshes
		} catch {
			print("ERROR::LOADING_MESH::__\(modelName)__\(error)")
		}
	}
	
	func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {
		guard let meshes = self._meshes as? [MTKMesh] else {return}
		for mesh in meshes {
			for vertexBuffer in mesh.vertexBuffers {
				renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer,
													 offset: vertexBuffer.offset,
													 index: 0)
				for submesh in mesh.submeshes {
					renderCommandEncoder.drawIndexedPrimitives(
						type: submesh.primitiveType,
						indexCount: submesh.indexCount,
						indexType: submesh.indexType,
						indexBuffer: submesh.indexBuffer.buffer,
						indexBufferOffset: submesh.indexBuffer.offset,
						instanceCount:  instanceCount)
				}
			}
		}
	}
	
	
}
