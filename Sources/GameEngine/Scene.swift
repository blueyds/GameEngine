//
//  Scene.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit
import GameplayKit

open class GameScene: GameNode {
	
	public var _meshManager = MeshManager()
	public var _lightManager = LightManager()
	public var _camera: CameraComponent?
	public var _sceneConstants = SceneConstants()
	// private component systems
	
	// var camera = DebugCamera()
	public init(){
		super.init(name: "Scene")
		self.root = self
		self.parent = self
		buildScene()
		print(self)
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open func buildScene(){	}

	public func updateScene(deltaTime: TimeInterval) {
		if let camera = _camera {
			_sceneConstants.viewMatrix = camera.viewMatrix
			_sceneConstants.projectionMatrix = camera.projectionMatrix
			if let node = camera.entity as? GameNode {
				_sceneConstants.cameraPosition = node.getPosition()
			}
		}
		_sceneConstants.totalGameTime = Float(deltaTime)

		updateChildrenMatrix()
		_meshManager.updateAll(deltaTime: deltaTime)
		_lightManager.updateAll(deltaTime: deltaTime)
		
		doUpdate(deltaTime: deltaTime)
		children.forEach(){ $0.update(deltaTime: deltaTime)	}
		_meshManager.updateAll(deltaTime: deltaTime)
	}
	// doUPdate can be overriden by  subclass to provide a hook to update special component systems before running mesh updater
	open func doUpdate(deltaTime: TimeInterval){
		
	}
	
	public func render(renderCommandEncoder: MTLRenderCommandEncoder) {
		
		renderCommandEncoder.setVertexBytes(&_sceneConstants, length: SceneConstants.stride, index: 1)
		_lightManager.setLightData(renderCommandEncoder)
		_meshManager.renderAll(rce: renderCommandEncoder)
	}
}
// mesh extensions for the scene
extension GameScene {
	public func addMeshComponent(_ mesh: Mesh, toChild: GameNode){
		let component = MeshComponent(mesh: mesh)
		toChild.addComponent(component)
		_meshManager.addComponent(foundIn: toChild)
	}
	public func addMeshComponent(_ mesh: Mesh, toChild: GameNode, instanceCount: Int){
		let component = MeshComponent(mesh: mesh, instanceCount: instanceCount)
		toChild.addComponent(component)
		_meshManager.addComponent(foundIn: toChild)
	}
	public func removeMeshComponent(fromChild: GameNode){
		fromChild.removeComponent(ofType: MeshComponent.self)
		_meshManager.removeComponent(foundIn: fromChild)
	}
}
// light extensions for the scene
extension GameScene {
	public func addLightComponent(toChild: GameNode){
		let component = LightComponent()
		toChild.addComponent(component)
		_lightManager.addComponent(foundIn: toChild)
	}
	// MARK: todo may need to remove from the lightmanager
	public func removeLightComponent(fromChild: GameNode){
		fromChild.removeComponent(ofType: LightComponent.self)
		_lightManager.removeComponent(foundIn: fromChild)
	}
}

// camera extensions for the scene
extension GameScene {
	public func addCameraComponent(toChild: GameNode,cameraType: CameraComponent.Types, fov: Float, aspectRatio: Float, near: Float, far: Float){
		let component = CameraComponent(cameraType: cameraType, fov: fov, aspectRatio: aspectRatio, near: near, far: far)
		toChild.addComponent(component)
		if _camera != nil {
			if let node = _camera?.entity as? GameNode {
				removeCameraComponent(fromChild: node)
			}
		}
		_camera = toChild.component(ofType: CameraComponent.self)
	}
	public func removeCameraComponent(fromChild: GameNode) {
		fromChild.removeComponent(ofType: CameraComponent.self)
		_camera = nil
	}
}

extension GameNode {
	public var Scene: GameScene? {
		self.root as? GameScene
	}
}

