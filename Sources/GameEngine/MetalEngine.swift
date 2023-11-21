//
//  Engine.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit
 var GlobalEngine: EngineProtocol!
 
public func registerGlobalEngine(_ engine: EngineProtocol){
	GlobalEngine = engine
}

/// Set of basic libraries that the game should implement in order to have a basic engine in place.
public protocol EngineProtocol {
	var device: MTLDevice! { get }
	var commandQueue: MTLCommandQueue { get }
	var shaders: ShaderLibrary { get }
	var descriptors: VertexDescriptorLibrary { get }
	var depthStencilStates: DepthStencilStateLibrary { get }
	var samplerStates: SamplerStateLibrary { get }
	var renderStates: RenderPipelineLibrary { get }
}