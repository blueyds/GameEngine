//
//  Engine.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit

final class Engine {
	static let shared: Engine = Engine()
	let device: MTLDevice!
	let commandQueue: MTLCommandQueue!
	var screenSize = simd_float2(repeating: 0)
	private let _shaders: ShaderLibrary
	private let _descriptors: VertexDescriptorLibrary
//	private let _renderDescriptors: RenderDescriptorLibrary
	private let _renderStates: RenderPipelineLibrary
	private let _meshes: Entities
	private let _preferences: Preferences
	private let _depthStencilStates: DepthStencilStateLibrary
	private let _textures: TextureLibrary
	private let _samplerStates: SamplerStateLibrary
	
	func Vertex(_ vertexFunctionType: ShaderLibrary.VertexShaderTypes)-> MTLFunction{
		_shaders.Vertex(vertexFunctionType)
	}
	func Fragment(_ fragmentFunctionType: ShaderLibrary.FragmentShaderTypes)-> MTLFunction{
		_shaders.Fragment(fragmentFunctionType)
	}
	func Descriptor(_ vertexDescriptorType: VertexDescriptorLibrary.Types)->MTLVertexDescriptor{
		_descriptors.descriptor(vertexDescriptorType)
	}
//	func RenderDescriptor(_ renderDescriptionType: RenderDescriptorLibrary.Types)-> MTLRenderPipelineDescriptor{
//		_renderDescriptors.descriptor(renderDescriptionType)
//	}
	func RenderState(_ renderPipelineStateType: RenderPipelineLibrary.Types)-> MTLRenderPipelineState {
		_renderStates.renderState(renderPipelineStateType)
	}
	func Mesh(_ meshType: Entities.Types)->Mesh {
		_meshes.mesh(meshType)
	}
	
	func DepthStencilStates(_ depthStencilStateType: DepthStencilStateLibrary.Types)-> MTLDepthStencilState {
		_depthStencilStates.DepthStencilState(depthStencilStateType)
	}
	func Texture(_ textureType: TextureLibrary.Types)-> MTLTexture?{
		_textures[textureType]
	}
	
	func SamplerState(_ samplerStateType: SamplerStateLibrary.Types) -> MTLSamplerState{
		_samplerStates[samplerStateType]
	}
	
	
	private init () {
		if let local_device = MTLCreateSystemDefaultDevice(){
			self.device = local_device
		} else { fatalError("Could not create metal device") }
		if let cq = device.makeCommandQueue() {
			self.commandQueue = cq
		} else { fatalError("Could not create command queue") }
		self._preferences = Preferences.shared
		self._shaders = ShaderLibrary(device: self.device)
		self._descriptors = VertexDescriptorLibrary()
		self._renderStates = RenderPipelineLibrary(device: device, library: _shaders, vertexDescriptorLibrary: _descriptors, preferences: _preferences)
		self._meshes = Entities(device: device, vertexDescriptorLibrary: self._descriptors)
		self._depthStencilStates = DepthStencilStateLibrary(device: device)
		self._textures = TextureLibrary(device: device)
		self._samplerStates = SamplerStateLibrary(device: device)
	}
}
