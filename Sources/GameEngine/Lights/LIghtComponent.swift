//
//  LIghtComponent.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit


public class LightComponent: GKComponent {
	public var lightData: LightData = LightData()
	public weak var node: GameNode {
		if let n = entity as? GameNode {
			return n
		} else {
			fatalError("Node is not a gamenode in lightcomponent")
		}
	}
	public override init(){
		lightData = LightData()
		super.init()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func update(deltaTime: TimeInterval) {
		lightData.position = node.position
	}
}

extension LightComponent {
	// Light Color
	public func color(_ color: simd_float3) -> LightComponent {
		let result = self
		result.lightData.color = color
		return result
	}
	// Light Brighness
	public func brightness(_ brightness: Float) -> LightComponent {
		let result = self
		result.lightData.brightness = brightness
		return result
	}
	// Ambient Intensity
	public func ambientIntensity(_ intensity: Float) -> LightComponent {
		let result = self
		result.lightData.ambientIntensity = intensity
		return result
	}
		// Diffuse Intensity
	public func diffuseIntensity(_ intensity: Float) -> LightComponent {
		let result = self
		result.lightData.diffuseIntensity = intensity
		return result
	}
	// Specular Intensity
	public func specularIntensity(_ intensity: Float) -> LightComponent {
		let result = self
		result.lightData.specularIntensity = intensity
		return result
	}
}

extension GameNode {
	public var Light: LightComponent? {
		component(ofType: LightComponent.self)
	}
}
