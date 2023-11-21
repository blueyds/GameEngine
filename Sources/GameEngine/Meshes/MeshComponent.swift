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
				self.renderState = MeshComponent.Engine!.renderStates["default"]!
			} else {
				self.material.useTexture = true
				self.material.useMaterialColor = false
                // TODO: should bel basicRenderwithNoDepth
				self.renderState = MeshComponent.Engine!.renderStates["default"]!

			}	
		}
	}
	var mesh: Mesh!
	
	private var _modelConstantBuffer: MTLBuffer!
	var renderState: MTLRenderPipelineState
	var depthStencilState: MTLDepthStencilState
	var samplerState: MTLSamplerState
	weak var _node: GameNode? {
        entity as? GameNode
	}
	public init (mesh: Mesh) {
	
		self.mesh = mesh
		self.material = Material()
		renderState = engine.renderStates["default"]!
		depthStencilState = GlobalEngine.depthStencilStates["default"]!
		samplerState = GlobalEngine.samplerStates["default"]!
		super.init()
        createModelConstants(1)
	}
	public init(mesh: Mesh, instanceCount: Int){
		self.mesh = mesh
		mesh.setInstanceCount(instanceCount)
		
		renderState = GlobalEngine.renderStates["default"]!
		depthStencilState = GlobalEngine.depthStencilStates["default"]!
		samplerState = GlobalEngine.samplerStates["default"]!
		super.init()
		createModelConstants(instanceCount)
		createBuffers(instanceCount)
	}
	
	public override func didAddToEntity(){
		if modelConstants.count != 1 {
			for _ in 0..<modelConstants.count {
				_node!.addChild(GameNode(name: "\(_node!.name).Instanced_node"))
			}
		}
	}
	
	func createModelConstants(_ instanceCount: Int){
		for _ in 0..<instanceCount {
			modelConstants.append(ModelConstants())
		}
	}
	func createBuffers(_ instanceCount: Int){
		_modelConstantBuffer = GlobalEngine.device.makeBuffer(	length: ModelConstants.stride(instanceCount), options: [])
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public override func update(deltaTime: TimeInterval) {
		updateModelConstants()
		super.update(deltaTime: deltaTime)
	}
	
	
	private func updateModelConstants(){
		if modelConstants.count == 1 {
			modelConstants[0].modelMatrix = _node!.modelMatrix
		} else {
			var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _node!.children.count)
			for child in _node!.children {
				pointer.pointee.modelMatrix = child.modelMatrix
				pointer = pointer.advanced(by: 1)
			}
		}
    }
	
	public func doRender(_ rCe: MTLRenderCommandEncoder) {
	    rCe.pushDebugGroup(_node!.name)
       rCe.setRenderPipelineState(renderState)

		
		//Vertex Shader
		if modelConstants.count == 1 {
			rCe.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
		}else{
			rCe.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
		}
		
		
		//Fragment Shader
		rCe.setFragmentSamplerState(samplerState, index: 0)
		rCe.setFragmentBytes(&material, length: Material.stride, index: 1)
		if(material.useTexture){
			rCe.setFragmentTexture(texture!.texture, index: 0)
			rCe.setDepthStencilState(depthStencilState)
		}
		mesh.drawPrimitives(rCe)
         rCe.popDebugGroup()
		
	}
}
// modifier extensions
extension MeshComponent{
	public func texture(_ texture: Texture) -> MeshComponent{
		let result = self
		result.texture = texture
		return result
	}
	public func color(_ color: Float4)-> MeshComponent{
		let result = self
		result.material.color = color
		return result

	}
	public func color(_ color: GameColor)-> MeshComponent{
		let result = self
		result.material.color = color.vector
		return result
	}
	public func ambient(_ color: Float3)-> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.ambient = color
		return result

	}
	public func ambient(_ color: Float) -> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.ambient = Float3(repeating: color)
		return result
	}
	public func diffuse(_ color: Float3)-> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.diffuse = color
		return result
	}
	public func diffuse(_ color: Float) -> MeshComponent {
		let result = self
		result.material.isLit = true
		result.material.diffuse = Float3(repeating: color)
		return result
	}
	public func specular(_ color: Float3)-> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.specular = color
		return result
	}
	public func specular(_ color: Float) -> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.specular = Float3(repeating: color)
		return result
	}
	public func shininess(_ value: Float)-> MeshComponent{
		let result = self
		result.material.isLit = true
		result.material.shininess = value
		return result

	}
	public func isLit(_ value: Bool)-> MeshComponent{
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

