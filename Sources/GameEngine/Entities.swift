//
//  MeshLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit


public protocol Mesh {
	func setInstanceCount(_ count: Int)
	func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
// TODO: rename entities
public class Entities {
	public enum Types {
		case None
		case Triangle_Custom
		case Quad_Custom
		case Cube_Custom
		case Cruiser
		case Sphere
	}
	private var _meshes: [Types:Mesh] = [:]
	private var _device: MTLDevice!
	private var _vertexDescriptorLibirary: VertexDescriptorLibrary
	
	public init(device: MTLDevice!, vertexDescriptorLibrary: VertexDescriptorLibrary){
		self._device = device
		self._vertexDescriptorLibirary = vertexDescriptorLibrary
		createDefaultMeshes()
	}
	private func createDefaultMeshes(){
		_meshes.updateValue(NoMesh(), forKey: .None)
		_meshes.updateValue(Triangle_CustomMesh(device: _device), forKey: .Triangle_Custom)
		_meshes.updateValue(Quad_CustomMesh(device: _device), forKey: .Quad_Custom)
		_meshes.updateValue(Cube_CustomMesh(device: _device), forKey: .Cube_Custom)
		loadModelMesh(modelName: "cruiser", forKey: .Cruiser)
		loadModelMesh(modelName: "sphere", forKey: .Sphere)
		
	}
	private func loadModelMesh(modelName: String, ext: String = "obj", forKey: Types){
		_meshes.updateValue(
			ModelMesh(modelName: modelName,
					  ext: ext,
					  vertexDescriptor: _vertexDescriptorLibirary.descriptor(.Basic),
					  device: _device),
			forKey: forKey)
	}
	public func mesh(_ meshType: Types)->Mesh{
		_meshes[meshType]!
	}
	
}





