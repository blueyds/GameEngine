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
			$0.doRender(rce)
        }
	}
	public func addComponent(foundIn fromNode: GKEntity) {
		_components.addComponent(foundIn: fromNode)
		print("WE now have \(_components.components.count) meshes in our meshManager")
	}
	public func removeComponent(foundIn fromNode: GKEntity){
		
		_components.removeComponent(foundIn: fromNode)
	}
	
}
