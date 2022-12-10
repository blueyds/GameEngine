//
//  Node.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit
import simd
import GameplayKit

//import GameMeshes
//import GameComponents

open class GameNode: GKEntity, Identifiable {
	public var name: String
	public let id = UUID()
	public weak var parent: GameNode?
	public weak var root: GameNode?
	
	
	public var position: simd_float3 = simd_float3(0.0, 0.0, 0.0)
	public var scale: simd_float3 = simd_float3(1.0, 1.0, 1.0)
	public var rotation: simd_float3 = simd_float3(0.0, 0.0, 0.0)
	
	public var parentModelMatrix = matrix_identity_float4x4
	public var modelMatrix : matrix_float4x4 {
		var matrix = matrix_identity_float4x4
		matrix.translate(direction: position)
		matrix.scale(axis: scale)
		matrix.rotate(angle: rotation.x, axis: .x)
		matrix.rotate(angle: rotation.y, axis: .y)
		matrix.rotate(angle: rotation.z, axis: .z)
		return matrix_multiply(parentModelMatrix, matrix)
		
	}
	public var children: [GameNode] = []
	
	public init(name: String, parent: GameNode? = nil){
		self.name = name
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

// modifier extensions
extension GameNode {
	func setPosition(_ pos: simd_float3) -> GameNode {
		let result = self
		result.position = pos
		return result
	}
	func setScale(by value: simd_float3) -> GameNode {
		let result = self
		result.scale = value
		return result
	}
	func setScale(by value: Float) -> GameNode {
		let result = self
		result.scale = simd_float3(repeating: value)
		return result
	}
	func setRotation(by value: simd_float3) -> GameNode {
		let result = self
		result.rotation = value
		return result
	}
}
