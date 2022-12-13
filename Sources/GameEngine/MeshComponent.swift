//
//  MeshComponent.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit


public class MeshComponent: GKComponent {
	var modelConstants: [ModelConstants] = []
	public var material: Material = Material()
	public var texture: Texture?{
		didSet {
			if texture == nil {
				self.material.useTexture = false
				self.material.useMaterialColor = true
				self.renderState = MeshComponent.Engine!.defaultBasicRenderState
			} else {
				self.material.useTexture = true
				self.material.useMaterialColor = false
				self.renderState = MeshComponent.Engine!.basicRenderStateNoDepth

			}	
		}
	}
	var mesh: Mesh!
	static public var Engine: EngineProtocol? = nil{
		didSet{
			CustomMesh.Engine = Engine
			ModelMesh.Engine = Engine
		}
	}
	private var _modelConstantBuffer: MTLBuffer!
	var renderState: MTLRenderPipelineState
	var depthStencilState: MTLDepthStencilState
	var samplerState: MTLSamplerState
	
	public init (mesh: Mesh) {
	
		self.mesh = mesh
		self.material = Material()
		modelConstants.append(ModelConstants())
		if MeshComponent.Engine == nil {
			fatalError("Set MeshComponent.engine prior to initializing any meshes")
		}
		renderState = MeshComponent.Engine!.basicRenderStateNoDepth
		depthStencilState = MeshComponent.Engine!.defaultDepthStencilState
		samplerState = MeshComponent.Engine!.defaultSamplerState
		super.init()
	}
	public init(mesh: Mesh, instanceCount: Int){
		self.mesh = mesh
		mesh.setInstanceCount(instanceCount)
		if MeshComponent.Engine == nil {
			fatalError("Set MeshComponent.engine prior to initializing any meshes")
		}
		renderState = MeshComponent.Engine!.defaultInstancedRenderState
		depthStencilState = MeshComponent.Engine!.defaultDepthStencilState
		samplerState = MeshComponent.Engine!.defaultSamplerState
		super.init()
		createModelConstants(instanceCount)
		createBuffers(instanceCount)
	}
	
	public override func didAddToEntity(){
		if modelConstants.count != 1 {
			if let node = entity as? GameNode {
				for _ in 0..<modelConstants.count {
					node.addChild(GameNode(name: "\(node.name).Instanced_node"))
				}
			}else {fatalError("entity is not a node.")}
		}
		
	}
	
	func createModelConstants(_ instanceCount: Int){
		for _ in 0..<instanceCount {
			modelConstants.append(ModelConstants())
		}
	}
	func createBuffers(_ instanceCount: Int){
		_modelConstantBuffer = MeshComponent.Engine?.device.makeBuffer(	length: ModelConstants.stride(instanceCount), options: [])
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public override func update(deltaTime: TimeInterval) {
		updateModelConstants()
		super.update(deltaTime: deltaTime)
	}
	
	
	private func updateModelConstants(){
		if let node = entity as? GameNode {
			if modelConstants.count == 1 {
				modelConstants[0].modelMatrix = node.modelMatrix
			}
			else {
				var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: node.children.count)
				for child in node.children {
					pointer.pointee.modelMatrix = child.modelMatrix
					pointer = pointer.advanced(by: 1)
				}
			}
		}
	}
	
	public func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
	
		renderCommandEncoder.setRenderPipelineState(renderState)

		
		//Vertex Shader
		if modelConstants.count == 1 {
			renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
		}else{
			renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
		}
		
		
		//Fragment Shader
		renderCommandEncoder.setFragmentSamplerState(samplerState, index: 0)
		renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
		if(material.useTexture){
			renderCommandEncoder.setFragmentTexture(texture!.texture, index: 0)
			renderCommandEncoder.setDepthStencilState(depthStencilState)
		}
		mesh.drawPrimitives(renderCommandEncoder)
	}
}
// modifier extensions
extension MeshComponent{
	func texture(_ texture: Texture) -> MeshComponent{
		let result = self
		result.texture = texture
		return result
	}
	func color(_ color: simd_float4)-> MeshComponent{
		let result = self
		result.material.color = color
		return result

	}
	func ambient(_ color: simd_float3)-> MeshComponent{
		let result = self
		result.material.ambient = color
		return result

	}
	func diffuse(_ color: simd_float3)-> MeshComponent{
		let result = self
		result.material.diffuse = color
		return result

	}
	func specular(_ color: simd_float3)-> MeshComponent{
		let result = self
		result.material.specular = color
		return result

	}
	func shininess(_ value: Float)-> MeshComponent{
		let result = self
		result.material.shininess = value
		return result

	}
	func isLit(_ value: Bool)-> MeshComponent{
		let result = self
		result.material.isLit = value
		return result

	}
}


extension GameNode {
	public var Mesh: MeshComponent? {
		component(ofType: MeshComponent.self)
	}
}

