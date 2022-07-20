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
	public override init(){
		lightData = LightData()
		super.init()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func update(deltaTime: TimeInterval) {
		if let node = entity as? GameNode {
			lightData.position = node.getPosition()
		}
	}
}

extension LightComponent {
	// Light Color
	public func setLightColor(_ color: simd_float3){
		lightData.color = color
	}
	public func setLightColor(r: Float, g: Float, b: Float){
		setLightColor(simd_float3(r, g, b))
	}
	public func getLightColor()->simd_float3 {
		lightData.color
	}
	// Light Brighness
	public func setLightBrightness(_ brightness: Float){
		lightData.brightness = brightness
	}
	public func getLightBrightness()-> Float {
		lightData.brightness
	}
	
	// Ambient Intensity
	public func setLigtAmbientIntensity(_ intensity: Float) {
		lightData.ambientIntensity = intensity
	}
	public func getLightAmbientIntensity()-> Float {
		lightData.ambientIntensity
	}
	
	// Diffuse Intensity
	public func setLigtDiffuseIntensity(_ intensity: Float) {
		lightData.diffuseIntensity = intensity
	}
	public func getLightDiffuseIntensity()-> Float {
		lightData.diffuseIntensity
	}
	
	// Specular Intensity
	public func setLightSpecularIntensity(_ intensity: Float) {
		lightData.specularIntensity = intensity
	}
	public func getLightSpecularIntensity()->Float {
		lightData.specularIntensity
	}
}
