//
//  ShaderLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit


/// <#Description#>
public class ShaderLibrary {
//	public enum VertexShaderTypes{
//		case Basic
//		case Instanced
//	}
//	public enum FragmentShaderTypes{
//		case Basic
//	}

	private var library: MTLLibrary!
	private let device: MTLDevice!
	private var vertexShaders: [String: Shader] = [:]
    private var fragmentShaders: [String: Shader] = [:]
	public init (device: MTLDevice){
		self.device = device
		guard let lib = self.device.makeDefaultLibrary()
		else { fatalError("Could not create library")}
		self.library = lib
	}
	public init(source: String, using device: MTLDevice){
		self.device = device
		if let lib = try? self.device.makeLibrary(source: source, options: nil){
			self.library = lib
		} else 	{
		fatalError("Could not create library")
		}
	}
	public func createVertexShader(_ name: String, functionName: String){
		vertexShaders.updateValue(createShader(functionName), forKey: name)
	}
    
	public func createFragmentShader(_ name: String, functionName: String) {
		fragmentShaders.updateValue(createShader(functionName), forKey: name)
	}
    private func createShader(_ functionName: String)-> Shader{
        Shader(functionName: functionName, library: library)
    }
	public subscript(_ name: String, _ fnType: FunctionType) -> MTLFunction? {
		switch fnType{
            case vertex:
                return vertexShaders[name]?.function
            case fragment:
                return fragmentShaders[name]?.function
		}
	}
}

extension ShaderLibrary {
    public enum FunctionType {
        case vertex
        case fragment
    }
	public class Shader {
		var functionName: String
		var function: MTLFunction
		public init(functionName: String, library: MTLLibrary!){
			self.functionName = functionName
			if let fn = library.makeFunction(name: functionName){
				self.function = fn	
			} else {
				fatalError("Could not load function named \(functionName)")
			}
		}
	}
}
