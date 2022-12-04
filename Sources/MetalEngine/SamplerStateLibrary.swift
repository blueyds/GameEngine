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
	private var _states: [SamplerState]=[]
	private var _device: MTLDevice
	public init(device: MTLDevice){
		_device = device
		createdefaultSamplers()
	}
	private func createdefaultSamplers(){
		addSampler(named: "Linear Sampler State", minFilter: .linear, magFilter: .linear)
	}
	public func addSampler(named name: String, minFilter: MTLSamplerMinMagFilter, magFilter: MTLSamplerMinMagFilter){
		_states.append(SamplerState(name, minFilter: minFilter, magFilter: magFilter, device: _device) )
	}
	public subscript(_ name: String) -> MTLSamplerState? {
		_states.first(where: {$0.name == name})?.samplerState
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
