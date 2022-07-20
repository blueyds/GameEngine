//
//  Node.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit
import GameplayKit
class GameNode: GKEntity, Identifiable{
	private var _name: String
	let id = UUID()
	
	private var _position: simd_float3 = simd_float3(repeating: 0)
	private var _scale: simd_float3 = simd_float3(repeating: 1)
	private var _rotation: simd_float3 = simd_float3(repeating: 0)
	
	var parentModelMatrix = matrix_identity_float4x4
	var modelMatrix : matrix_float4x4 {
		var matrix = matrix_identity_float4x4
		matrix.translate(direction: _position)
		matrix.scale(axis: _scale)
		matrix.rotate(angle: _rotation.x, axis: .x)
		matrix.rotate(angle: _rotation.y, axis: .y)
		matrix.rotate(angle: _rotation.z, axis: .z)
		return matrix_multiply(parentModelMatrix, matrix)
		
	}
	var children: [GameNode] = []
	
	init(name: String){
		self._name = name
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func addChild(_ child: GameNode){
		children.append(child)
	}
	
	
	func updateChildrenMatrix(){
//		if let updateable = self as? Updateable {
//			updateable.doUpdate(GameTime.DeltaTime)
//		}
		for child in children {
			child.parentModelMatrix = self.modelMatrix
			child.updateChildrenMatrix()
		}
	}
	
}
// General translation extensions
extension GameNode {
	//Naming
	func setName(_ name: String){ self._name = name }
	func getName()->String{ return _name }
	func getID()->String { return id.uuidString }
	
	//Positioning and Movement
	func setPosition(_ position: simd_float3){ self._position = position }
	func setPositionX(_ xPosition: Float) { self._position.x = xPosition }
	func setPositionY(_ yPosition: Float) { self._position.y = yPosition }
	func setPositionZ(_ zPosition: Float) { self._position.z = zPosition }
	func setPosition(x: Float, y: Float, z: Float) { setPosition(simd_float3(x, y, z))}
	func getPosition()->simd_float3 { return self._position }
	func getPositionX()->Float { return self._position.x }
	func getPositionY()->Float { return self._position.y }
	func getPositionZ()->Float { return self._position.z }
	func move(_ x: Float, _ y: Float, _ z: Float){ self._position += simd_float3(x,y,z) }
	func moveX(_ delta: Float){ self._position.x += delta }
	func moveY(_ delta: Float){ self._position.y += delta }
	func moveZ(_ delta: Float){ self._position.z += delta }
	
	//Rotating
	func setRotation(_ rotation: simd_float3) { self._rotation = rotation }
	func setRotation(x: Float, y: Float, z: Float){setRotation(simd_float3(x, y, z))}
	func setRotationX(_ xRotation: Float) { self._rotation.x = xRotation }
	func setRotationY(_ yRotation: Float) { self._rotation.y = yRotation }
	func setRotationZ(_ zRotation: Float) { self._rotation.z = zRotation }
	func getRotation()->simd_float3 { return self._rotation }
	func getRotationX()->Float { return self._rotation.x }
	func getRotationY()->Float { return self._rotation.y }
	func getRotationZ()->Float { return self._rotation.z }
	func rotate(_ x: Float, _ y: Float, _ z: Float){ self._rotation += simd_float3(x,y,z) }
	func rotateX(_ delta: Float){ self._rotation.x += delta }
	func rotateY(_ delta: Float){ self._rotation.y += delta }
	func rotateZ(_ delta: Float){ self._rotation.z += delta }
	
	//Scaling
	func setScale(_ scale: simd_float3){ self._scale = scale }
	func setScale(_ scale: Float){setScale(simd_float3(scale, scale, scale))}
	func setScaleX(_ scaleX: Float){ self._scale.x = scaleX }
	func setScaleY(_ scaleY: Float){ self._scale.y = scaleY }
	func setScaleZ(_ scaleZ: Float){ self._scale.z = scaleZ }
	func getScale()->simd_float3 { return self._scale }
	func getScaleX()->Float { return self._scale.x }
	func getScaleY()->Float { return self._scale.y }
	func getScaleZ()->Float { return self._scale.z }
	func scaleX(_ delta: Float){ self._scale.x += delta }
	func scaleY(_ delta: Float){ self._scale.y += delta }
	func scaleZ(_ delta: Float){ self._scale.z += delta }
}

//// Mesh Extensions
//extension  Node {
//	func addMesh(_ meshType: Entities.Types, count: Int){
//		// MARK: Todo add InstancedMeshComponent
//		let component = MeshComponent(meshType: meshType, instanceCount: count)
//		addComponent(component)
//	}
//	func addMesh(_ meshType: Entities.Types){
//		let component = MeshComponent(meshType: meshType)
//		addComponent(component)
//	}
//	func removeMesh(){
//		removeComponent(ofType: MeshComponent.self)
//	}
//
//}

//// Light Extensions
//extension Node {
//	func addLight() {
//		let component = LightComponent()
//		addComponent(component)
//
//	}
//	func removeLIght(){
//		removeComponent(ofType: LightComponent.self)
//	}
//
//}

// Camera extensions
//extension Node {
//	func addCamera(_ cameraType: CameraComponent.Types) {
//		let component = CameraComponent(cameraType: cameraType)
//		addComponent(component)
//	}
//	func addCamera(_ cameraType: CameraComponent.Types, zoom: Float, aspectRatio: Float, near: Float, far: Float){
//		let component = CameraComponent(cameraType: cameraType, zoom: zoom, aspectRatio: aspectRatio, near: near, far: far)
//		addComponent(component)
//	}
////	func addCamera(_ cameraType: CameraComponent.Types) {
////		let component = CameraComponent(cameraType: cameraType)
////		addComponent(component)
////	}
//	func removeCamera(){
//		removeComponent(ofType: CameraComponent.self)
//	}
//}
