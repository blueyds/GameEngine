//
//  SamplerState.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/7/22.
//

import Foundation
import Metal

public class SamplerStateLibrary {
	public enum Types {
		case None
		case Linear
	}
	private var _states: [String: MTLSamplerState]=[:]
	private var _device: MTLDevice
	public init(device: MTLDevice){
		_device = device
		createdefaultSamplers()
	}
	private func createdefaultSamplers(){
	//	addSampler(named: "Linear Sampler State", minFilter: .linear, magFilter: .linear)
	}
	public func addSampler(named name: String, minFilter: MTLSamplerMinMagFilter, magFilter: MTLSamplerMinMagFilter){
		_states.updateValue(createSamplerState(name: name, minFilter: minFilter, magFilter: magFilter),forKey: name )
	}
	public subscript(_ name: String) -> MTLSamplerState? {
		_states[name]
	}
	private func createSamplerState(name: String, minFilter: MTLSamplerMinMagFilter, magFilter: MTLSamplerMinMagFilter)->MTLSamplerState{
		let samplerDescriptor = MTLSamplerDescriptor()
		samplerDescriptor.minFilter = minFilter
		samplerDescriptor.magFilter = magFilter
		samplerDescriptor.label = name
		return _device.makeSamplerState(descriptor: samplerDescriptor)!
	}
}


