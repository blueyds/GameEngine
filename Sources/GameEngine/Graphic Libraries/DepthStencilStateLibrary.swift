//
//  DepthStencilStateLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/29/22.
//

import MetalKit

public class DepthStencilStateLibrary {
//	public enum Types {
//		case Less
//	}
	
	private var _depthStencilStates: [String: DepthStencilState ] = [:]
	
	private var device: MTLDevice
	
	public init(device: MTLDevice) {
		self.device = device
		createDefaultDepthStencilStates()
	}
	
	private func createDefaultDepthStencilStates(){
//		add(depthStencilState: DepthStencilState(device: device, isDepthWriteEnabled: true, depthCompareFunction: .less), named: "Less")
	}
	public func add(depthStencilState: DepthStencilState, named: String){
		_depthStencilStates.updateValue(depthStencilState, forKey: named)
	}
    public func add(named: String, isDepthWriteEnabled: Bool, depthCompareFunction: MTLCompareFunction) {
        let state = DepthStencilState(device: device, isDepthWriteEnabled: isDepthWriteEnabled, depthCompareFunction: depthCompareFunction)
        add(depthStencilState: state, named: named)
    }
	public subscript(name: String) ->MTLDepthStencilState? {
		_depthStencilStates[name]?.depthStencilState
	}

}
public class DepthStencilState{
	public var depthStencilState: MTLDepthStencilState!
	public init(device: MTLDevice,
				isDepthWriteEnabled: Bool,
				depthCompareFunction: MTLCompareFunction){
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = isDepthWriteEnabled
		depthStencilDescriptor.depthCompareFunction = depthCompareFunction
		depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
}
