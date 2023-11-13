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
	public var parent: GameNode? = nil
//	public var root: GameNode? = nil
	private var _scene: GameScene? = nil
	public var position = float3(0.0, 0.0, 0.0)
	public var scale = float3(1.0, 1.0, 1.0)
	public var rotation = float3(0.0, 0.0, 0.0)
	
	public var parentModelMatrix = matrix.identity
	public var modelMatrix : matrix {
		var matrix = matrix.identity
		matrix.translate(direction: position)
		matrix.scale(axis: scale)
		matrix.rotate(angle: rotation.x, axis: .x)
		matrix.rotate(angle: rotation.y, axis: .y)
		matrix.rotate(angle: rotation.z, axis: .z)
		return matrix_multiply(parentModelMatrix, matrix)
		
	}
	public var children: [GameNode] = []
	
	public init(name: String, parent: GameNode? = nil, scene: GameScene? = nil){
		self.name = name
		self.parent = parent
        self._scene = scene
		super.init()
	}
	
	public required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public func addChild(_ child: GameNode){
		child.parent = self
		child.root = self.root
        scanComponents(from: child)
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
	public func Position(_ pos: float3) -> GameNode {
		let result = self
		result.position = pos
		return result
	}
	public func Position(_ x: Float, _ y: Float, _ z: Float) -> GameNode {
		return Position(float3(x, y, z))
	}
	public func Scale(by value: float3) -> GameNode {
		let result = self
		result.scale = value
		return result
	}
	public func Scale(by value: Float) -> GameNode {
		let result = self
		result.scale = float3(repeating: value)
		return result
	}
	public func Rotation(by value: float3) -> GameNode {
		let result = self
		result.rotation = value
		return result
	}
}
