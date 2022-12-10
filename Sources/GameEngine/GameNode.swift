//
//  Node.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit
import GameplayKit

//import GameMeshes
//import GameComponents

open class GameNode: GKEntity, Identifiable {
	public var name: String
	public let id = UUID()
	public weak var parent: GameNode?
	public weak var root: GameNode?
	
	public var position: simd_float3 = simd_float3(repeating: 0)
	public var scale: simd_float3 = simd_float3(repeating: 1)
	public var rotation: simd_float3 = simd_float3(repeating: 0)
	
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
	
	public init(name: String, parent: GameNode? = nil){
		self._name = name
		self.parent = parent
		self.root = parent?.root
		super.init()
		if parent == nil {
			self.root = self
		}
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public func addChild(_ child: GameNode){
		children.append(child)
		child.parent = self
		
	}
	open func doUpdate(deltaTime: TimeInterval) {	}

	
	public func updateChildrenMatrix(){
		for child in children {
			child.parentModelMatrix = self.modelMatrix
			child.updateChildrenMatrix()
		}
	}
	
}
// General translation extensions
extension GameNode {
	// position
	public func move(_ x: Float, _ y: Float, _ z: Float){ self._position += simd_float3(x,y,z) }
	public func moveX(_ delta: Float){ self._position.x += delta }
	public func moveY(_ delta: Float){ self._position.y += delta }
	public func moveZ(_ delta: Float){ self._position.z += delta }
	
	//Rotating
	public func rotate(_ x: Float, _ y: Float, _ z: Float){ self._rotation += simd_float3(x,y,z) }
	public func rotateX(_ delta: Float){ self._rotation.x += delta }
	public func rotateY(_ delta: Float){ self._rotation.y += delta }
	public func rotateZ(_ delta: Float){ self._rotation.z += delta }
	
	//Scaling
	public func scaleX(_ delta: Float){ self._scale.x += delta }
	public func scaleY(_ delta: Float){ self._scale.y += delta }
	public func scaleZ(_ delta: Float){ self._scale.z += delta }
}
