//
//  LightManager.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit
class LightManager {
	//private var _lightObjects: [LightObject] = []
	var _components = GKComponentSystem<LightComponent>()
	
	init (){
		_components = GKComponentSystem<LightComponent>(componentClass: LightComponent.self)
	}

	
	func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
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
	func updateAll(deltaTime: TimeInterval){
		_components.update(deltaTime: deltaTime)
	}
	
	func addComponent(foundIn fromNode: GameNode){
		_components.addComponent(foundIn: fromNode)
		print("Light system has \(_components.components.count) lights")
	}
	func removeComponent(foundIn fromNode: GameNode){
		_components.removeComponent(foundIn: fromNode)
	}
}
