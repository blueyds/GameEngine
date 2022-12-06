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
	var material: Material = Material()
	var _texture: Texture?
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
		modelConstants.append(ModelConstants())
		if MeshComponent.Engine == nil {
			fatalError("Set MeshComponent.engine prior to initializing any meshes")
		}
		renderState = MeshComponent.Engine!.defaultBasicRenderState
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
					node.addChild(GameNode(name: "\(node.getName()).Instanced_node"))
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
		_modelConstantBuffer = MeshComponent.Engine?.device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
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
		renderCommandEncoder.setDepthStencilState(depthStencilState)
		
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
			renderCommandEncoder.setFragmentTexture(_texture!.texture, index: 0)
		}
		mesh.drawPrimitives(renderCommandEncoder)
	}
	
}


extension MeshComponent {
	public func setMaterialColor(_ color: simd_float4){
		self.material.color = color
		self.material.useMaterialColor = true
		material.useTexture = false
	}
	public func setMaterialColor(r: Float, g: Float, b: Float){
		setMaterialColor(simd_float4(r,g,b,1))
	}
	
	public func setTexture(_ texture: Texture){
		self.material.useTexture = true
		self.material.useMaterialColor = false
		self._texture = texture
	}
	// is lit
	public func setMaterialIsLit(_ isLit: Bool) {
		material.isLit = isLit
	}
	public func getMaterialIsLit()->Bool {
		material.isLit
	}
	
	// Ambient  getter and setters
	public func setMaterialAmbient(_ ambient: simd_float3){
		material.ambient = ambient
	}
	public func setMaterialAmbient(_ ambient: Float) {
		material.ambient = simd_float3(repeating: ambient)
	}
	public func setMaterialAmbient(_ r: Float, _ g: Float, _ b: Float){
		setMaterialAmbient(simd_float3(r,g,b))
	}
	public func addMaterialAmbient(_ value: Float) {
		material.ambient += value
	}
	public func getMaterialAmbient()->simd_float3 {
		material.ambient
	}
	// Diffuse  getter and setters
	public func setMaterialDiffuse(_ diffuse: simd_float3){
		material.diffuse = diffuse
	}
	public func setMaterialDiffuse(_ diffuse: Float) {
		material.diffuse = simd_float3(repeating: diffuse)
	}
	public func setMaterialDiffues(_ r: Float, _ g: Float, _ b: Float){
		setMaterialDiffuse(simd_float3(r, g, b))
	}
	public func addMaterialDiffuse(_ value: Float) {
		material.diffuse += value
	}
	public func getMaterialDiffuse()->simd_float3 {
		material.diffuse
	}
	
	// Specular  getter and setters
	public func setMaterialSpecular(_ specular: simd_float3){
		material.specular = specular
	}
	public func setMaterialSpecular(_ specular: Float) {
		material.specular = simd_float3(repeating: specular)
	}
	public func setMaterialSpecular(_ r: Float, _ g: Float, _ b: Float){
		setMaterialSpecular(simd_float3(r, g, b))
	}
	public func addMaterialSpecular(_ value: Float) {
		material.specular += value
	}
	public func getMaterialSpecular()->simd_float3 {
		material.specular
	}
	
	// Shininess
	public func setMaterialShininess(_ shininess: Float){
		material.shininess = shininess
	}
	public func getMaterialShininess()-> Float {
		material.shininess
	}
 }
extension GameNode {
	public var Mesh: MeshComponent? {
		component(ofType: MeshComponent.self)
	}
}

