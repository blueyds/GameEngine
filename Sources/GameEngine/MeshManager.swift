//
//  RenderManager.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit

class MeshManager {
	var _components: GKComponentSystem<MeshComponent>
	init (){
		_components = GKComponentSystem<MeshComponent>(componentClass: MeshComponent.self)
		
	}
	func updateAll(deltaTime: TimeInterval){
		_components.update(deltaTime: deltaTime)
	}
	func renderAll(rce: MTLRenderCommandEncoder){
		_components.components.forEach(){
			if let node = $0.entity as? GameNode {
				rce.pushDebugGroup(node.getName())
				$0.doRender(rce)
				rce.popDebugGroup()
			}
		}
	}
	func addComponent(foundIn fromNode: GameNode) {
		_components.addComponent(foundIn: fromNode)
		print("WE now have \(_components.components.count) meshes in our meshManager")
	}
	func removeComponent(foundIn fromNode: GameNode){
		
		_components.removeComponent(foundIn: fromNode)
	}
	
}
