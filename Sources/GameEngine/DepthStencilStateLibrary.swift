//
//  DepthStencilStateLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/29/22.
//

import MetalKit

public class DepthStencilStateLibrary {
	public enum Types {
		case Less
	}
	
	private var _depthStencilStates: [Types: DepthStencilState ] = [:]
	
	private var device: MTLDevice
	
	public init(device: MTLDevice) {
		self.device = device
		createDefaultDepthStencilStates()
	}
	
	private func createDefaultDepthStencilStates(){
		_depthStencilStates.updateValue(Less_DepthStencilState(device: device), forKey: .Less)
	}
	
	public func DepthStencilState(_ depthStencilState: Types)->MTLDepthStencilState{
		_depthStencilStates[depthStencilState]!.depthStencilState
	}
}

public protocol DepthStencilState {
	var depthStencilState: MTLDepthStencilState! { get }
}

public class Less_DepthStencilState: DepthStencilState {
	public var depthStencilState: MTLDepthStencilState!
	public init(device: MTLDevice){
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = true
		depthStencilDescriptor.depthCompareFunction = .less
		depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
	
}
