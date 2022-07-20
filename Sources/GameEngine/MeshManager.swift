//
//  RenderManager.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit
import GameplayKit

public class MeshManager {
	var _components: GKComponentSystem<MeshComponent>
	public init (){
		_components = GKComponentSystem<MeshComponent>(componentClass: MeshComponent.self)
		
	}
	public func updateAll(deltaTime: TimeInterval){
		_components.update(deltaTime: deltaTime)
	}
	public func renderAll(rce: MTLRenderCommandEncoder){
		_components.components.forEach(){
			if let node = $0.entity as? GameNode {
				rce.pushDebugGroup(node.getName())
				$0.doRender(rce)
				rce.popDebugGroup()
			}
		}
	}
	public func addComponent(foundIn fromNode: GameNode) {
		_components.addComponent(foundIn: fromNode)
		print("WE now have \(_components.components.count) meshes in our meshManager")
	}
	public func removeComponent(foundIn fromNode: GameNode){
		
		_components.removeComponent(foundIn: fromNode)
	}
	
}
