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
	private var shaders: [Shader]=[]

	public init (device: MTLDevice){
		self.device = device
		guard let lib = self.device.makeDefaultLibrary()
		else { fatalError("Could not create library")}
		self.library = lib
	}
	public init(source: String, using device: MTLDevice){
		self.device = device
		do{
			let lib = try self.device.makeLibrary(source: source, options: .none)
			self.library = lib
		}catch {fatalError("Could not create library")}

	}
	public func createVertexShader(_ name: String, functionName: String){
		shaders.append(
			Shader(name: name,
				functionName: functionName,
				   ofType: .vertex,
				  library: library) )
	}

	public func createFragmentShader(_ name: String, functionName: String) {
		shaders.append(
			Shader(name: name,
				functionName: functionName,
				   ofType: .fragment,
				  library: library) )
	}
	public subscript(name: String) -> MTLFunction? {
		shaders.first(where: {$0.name == name})?.function
	}

}

extension ShaderLibrary {
	public class Shader {
		var name: String
		var functionName: String
		var function: MTLFunction
		public enum FunctionType {
			case vertex, fragment
		}
		var fnType: FunctionType
		public init(name: String, functionName: String, ofType: FunctionType, library: MTLLibrary!){
			self.name = name
			self.functionName = functionName
			self.fnType = ofType
			if let fn = library.makeFunction(name: functionName){
				self.function = fn	
			} else {
				fatalerror("Could not load function named \(functionName)")
			}
		}
	}
}
