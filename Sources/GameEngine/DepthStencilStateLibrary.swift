//
//  DepthStencilStateLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/29/22.
//

import MetalKit

class DepthStencilStateLibrary {
	enum Types {
		case Less
	}
	
	private var _depthStencilStates: [Types: DepthStencilState ] = [:]
	
	private var device: MTLDevice
	
	init(device: MTLDevice) {
		self.device = device
		createDefaultDepthStencilStates()
	}
	
	private func createDefaultDepthStencilStates(){
		_depthStencilStates.updateValue(Less_DepthStencilState(device: device), forKey: .Less)
	}
	
	func DepthStencilState(_ depthStencilState: Types)->MTLDepthStencilState{
		_depthStencilStates[depthStencilState]!.depthStencilState
	}
}

protocol DepthStencilState {
	var depthStencilState: MTLDepthStencilState! { get }
}

class Less_DepthStencilState: DepthStencilState {
	var depthStencilState: MTLDepthStencilState!
	init(device: MTLDevice){
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = true
		depthStencilDescriptor.depthCompareFunction = .less
		depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
	
}
