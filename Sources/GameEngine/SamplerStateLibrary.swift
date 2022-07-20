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
	private var _states: [Types : SamplerState]=[:]
	private var _device: MTLDevice
	public init(device: MTLDevice){
		_device = device
		createdefaultSamplers()
	}
	private func createdefaultSamplers(){
		addSampler("Linear Sampler State", minFilter: .linear, magFilter: .linear, forKey: .Linear)
	}
	private func addSampler(_ name: String, minFilter: MTLSamplerMinMagFilter, magFilter: MTLSamplerMinMagFilter, forKey: Types){
		_states.updateValue(SamplerState(name, minFilter: minFilter, magFilter: magFilter, device: _device), forKey: forKey)
	}
	public subscript(_ type: Types) -> MTLSamplerState {
		(_states[type]?.samplerState)!
	}
}

public class SamplerState{
	public var name: String
	public var samplerState: MTLSamplerState
	public init(_ name: String, minFilter: MTLSamplerMinMagFilter = .linear, magFilter: MTLSamplerMinMagFilter = .linear, device: MTLDevice){
		self.name = name
		let samplerDescriptor = MTLSamplerDescriptor()
		samplerDescriptor.minFilter = minFilter
		samplerDescriptor.magFilter = magFilter
		samplerDescriptor.label = name
		samplerState = device.makeSamplerState(descriptor: samplerDescriptor)!
	}
}
