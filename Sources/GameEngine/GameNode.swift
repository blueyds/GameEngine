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
	var parent: GameNode? = nil
//	public var root: GameNode? = nil
	var scene: GameScene? = nil
	public var position = Float3(0.0, 0.0, 0.0)
	public var scale = Float3(1.0, 1.0, 1.0)
	public var rotation = Float3(0.0, 0.0, 0.0)
	
	public var parentModelMatrix = Matrix.identity
	public var modelMatrix : Matrix {
		var matrix = Matrix.identity
		matrix.translate(direction: position)
		matrix.scale(axis: scale)
		matrix.rotate(angle: rotation.x, axis: .x)
		matrix.rotate(angle: rotation.y, axis: .y)
		matrix.rotate(angle: rotation.z, axis: .z)
		return matrix_multiply(parentModelMatrix, matrix)
		
	}
	var children: [GameNode] = []
	
	public init(name: String, parent: GameNode? = nil){
		self.name = name
		super.init()
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public func addChild(_ child: GameNode){
		child.parent = self
		child.scene = self.scene
        scene!.scanComponents(from: child)
        children.append(child)
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
	public func Position(_ pos: Float3) -> GameNode {
		let result = self
		result.position = pos
		return result
	}
	public func Position(_ x: Float, _ y: Float, _ z: Float) -> GameNode {
		return Position(Float3(x, y, z))
	}
	public func Scale(by value: Float3) -> GameNode {
		let result = self
		result.scale = value
		return result
	}
	public func Scale(by value: Float) -> GameNode {
		let result = self
		result.scale = float3(repeating: value)
		return result
	}
	public func Rotation(by value: Float3) -> GameNode {
		let result = self
		result.rotation = value
		return result
	}
}
