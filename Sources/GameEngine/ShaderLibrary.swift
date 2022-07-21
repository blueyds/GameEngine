//
//  ShaderLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit


public class ShaderLibrary {
	public enum VertexShaderTypes{
		case Basic
		case Instanced
	}
	public enum FragmentShaderTypes{
		case Basic
	}

	private var library: MTLLibrary!
	private let device: MTLDevice!
	private var vertexShaders: [VertexShaderTypes: Shader]=[:]
	private var fragmentShaders: [FragmentShaderTypes: Shader]=[:]
	
	public init (device: MTLDevice){
		self.device = device
		guard let lib = try? self.device.makeDefaultLibrary(bundle: Bundle.module)
		else { fatalError("Could not create library")}
		self.library = lib
		createDefaultShaders()
	}
	public func createDefaultShaders(){
		createVertexShader("Basic Vertex Shader",	functionName: "basic_vertex_shader",forKey: .Basic)
		createVertexShader("Instanced Vertex Shader", functionName: "instanced_vertex_shader", forKey: .Instanced)
		
		createFragmentShader("Basic Fragment Shader", functionName: "basic_fragment_shader", forKey: .Basic)
	}
	public func createVertexShader(_ name: String, functionName: String, forKey: VertexShaderTypes){
		vertexShaders.updateValue(
			Shader(name: name,
				functionName: functionName,
				  library: library),
			forKey: forKey)
	}
	public func createFragmentShader(_ name: String, functionName: String, forKey: FragmentShaderTypes){
		fragmentShaders.updateValue(
			Shader(name: name,
				functionName: functionName,
				  library: library),
			forKey: forKey)
	}
	public func Vertex(_ vertexShaderType: VertexShaderTypes)-> MTLFunction{
		vertexShaders[vertexShaderType]!.function
	}
	public func Fragment(_ fragmentShaderType: FragmentShaderTypes) -> MTLFunction{
		fragmentShaders[fragmentShaderType]!.function
	}
}

extension ShaderLibrary {
	public class Shader {
		var name: String
		var functionName: String
		var function: MTLFunction
		public init(name: String, functionName: String, library: MTLLibrary!){
			self.name = name
			self.functionName = functionName
			self.function = library.makeFunction(name: functionName)!
		}
	}
}
