//
//  LightManager.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit
public class LightManager {
	//private var _lightObjects: [LightObject] = []
	var _components = GKComponentSystem<LightComponent>()
	
	public init (){
		_components = GKComponentSystem<LightComponent>(componentClass: LightComponent.self)
	}

	
	public func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
		var lightDatas: [LightData] = []
		_components.components.forEach(){
			lightDatas.append($0.lightData)
		}
		var lightCount = lightDatas.count
		renderCommandEncoder.setFragmentBytes(&lightCount,
											  length: Int.size,
											  index: 2)
		renderCommandEncoder.setFragmentBytes(&lightDatas,
											  length: LightData.stride(lightCount),
											  index: 3)
	}
	public func updateAll(deltaTime: TimeInterval){
		_components.update(deltaTime: deltaTime)
	}
	
	public func addComponent(foundIn fromNode: GameNode){
		_components.addComponent(foundIn: fromNode)
		print("Light system has \(_components.components.count) lights")
	}
	public func removeComponent(foundIn fromNode: GameNode){
		_components.removeComponent(foundIn: fromNode)
	}
}
