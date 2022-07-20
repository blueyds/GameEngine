//
//  Node.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit
import GameplayKit
public class GameNode: GKEntity, Identifiable{
	private var _name: String
	public let id = UUID()
	
	private var _position: simd_float3 = simd_float3(repeating: 0)
	private var _scale: simd_float3 = simd_float3(repeating: 1)
	private var _rotation: simd_float3 = simd_float3(repeating: 0)
	
	public var parentModelMatrix = matrix_identity_float4x4
	public var modelMatrix : matrix_float4x4 {
		var matrix = matrix_identity_float4x4
		matrix.translate(direction: _position)
		matrix.scale(axis: _scale)
		matrix.rotate(angle: _rotation.x, axis: .x)
		matrix.rotate(angle: _rotation.y, axis: .y)
		matrix.rotate(angle: _rotation.z, axis: .z)
		return matrix_multiply(parentModelMatrix, matrix)
		
	}
	public var children: [GameNode] = []
	
	public init(name: String){
		self._name = name
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public func addChild(_ child: GameNode){
		children.append(child)
	}
	
	
	public func updateChildrenMatrix(){
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
	public func setName(_ name: String){ self._name = name }
	public func getName()->String{ return _name }
	public func getID()->String { return id.uuidString }
	
	//Positioning and Movement
	public func setPosition(_ position: simd_float3){ self._position = position }
	public func setPositionX(_ xPosition: Float) { self._position.x = xPosition }
	public func setPositionY(_ yPosition: Float) { self._position.y = yPosition }
	public func setPositionZ(_ zPosition: Float) { self._position.z = zPosition }
	public func setPosition(x: Float, y: Float, z: Float) { setPosition(simd_float3(x, y, z))}
	public func getPosition()->simd_float3 { return self._position }
	public func getPositionX()->Float { return self._position.x }
	public func getPositionY()->Float { return self._position.y }
	public func getPositionZ()->Float { return self._position.z }
	public func move(_ x: Float, _ y: Float, _ z: Float){ self._position += simd_float3(x,y,z) }
	public func moveX(_ delta: Float){ self._position.x += delta }
	public func moveY(_ delta: Float){ self._position.y += delta }
	public func moveZ(_ delta: Float){ self._position.z += delta }
	
	//Rotating
	public func setRotation(_ rotation: simd_float3) { self._rotation = rotation }
	public func setRotation(x: Float, y: Float, z: Float){setRotation(simd_float3(x, y, z))}
	public func setRotationX(_ xRotation: Float) { self._rotation.x = xRotation }
	public func setRotationY(_ yRotation: Float) { self._rotation.y = yRotation }
	public func setRotationZ(_ zRotation: Float) { self._rotation.z = zRotation }
	public func getRotation()->simd_float3 { return self._rotation }
	public func getRotationX()->Float { return self._rotation.x }
	public func getRotationY()->Float { return self._rotation.y }
	public func getRotationZ()->Float { return self._rotation.z }
	public func rotate(_ x: Float, _ y: Float, _ z: Float){ self._rotation += simd_float3(x,y,z) }
	public func rotateX(_ delta: Float){ self._rotation.x += delta }
	public func rotateY(_ delta: Float){ self._rotation.y += delta }
	public func rotateZ(_ delta: Float){ self._rotation.z += delta }
	
	//Scaling
	public func setScale(_ scale: simd_float3){ self._scale = scale }
	public func setScale(_ scale: Float){setScale(simd_float3(scale, scale, scale))}
	public func setScaleX(_ scaleX: Float){ self._scale.x = scaleX }
	public func setScaleY(_ scaleY: Float){ self._scale.y = scaleY }
	public func setScaleZ(_ scaleZ: Float){ self._scale.z = scaleZ }
	public func getScale()->simd_float3 { return self._scale }
	public func getScaleX()->Float { return self._scale.x }
	public func getScaleY()->Float { return self._scale.y }
	public func getScaleZ()->Float { return self._scale.z }
	public func scaleX(_ delta: Float){ self._scale.x += delta }
	public func scaleY(_ delta: Float){ self._scale.y += delta }
	public func scaleZ(_ delta: Float){ self._scale.z += delta }
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
