//
//  GameNode.swift
//  Craigs Engine
//
//  Created by Craig Nunemaker on 6/10/22.
//

import GameplayKit


public class GameNode {
	public var entity: GKEntity = GKEntity()
	public var parent: GameNode? = nil
	public var count: Int {
		1 + children.reduce(0){
			$0 + $1.count
		}
	}
	private(set) var children: [GameNode] = []
	public init(){
		self.entity = GKEntity()
		self.children = []
		self.parent = nil
	}
	public init(entity: GKEntity, children: [GameNode]){
		self.entity = entity
		self.children = children
		self.parent = nil
		setParentOfChildren()
	}
	public init(@GameNodeBuilder builder: () -> [GameNode]){
		self.entity  = GKEntity()
		self.parent = nil
		self.children = builder()
		setParentOfChildren()
	}
	public init(node: GameNode, @GameNodeBuilder builder: () -> [GameNode]){
		self.entity = node.entity
		self.parent = node.parent
		self.children = builder()
		setParentOfChildren()
	}


	public func setParentOfChildren() {
		children.forEach(){
			$0.parent = self
		}
	}
	public func add(child: GameNode){
		children.append(child)
		child.parent = self
	}
}

extension GameNode : Equatable {
	public static func ==(lhs: GameNode, rhs: GameNode)-> Bool {
		lhs.entity == rhs.entity &&
		lhs.children == rhs.children
	}
}

extension GameNode: Hashable {
	public	func hash(into hasher: inout Hasher) {
		hasher.combine(entity)
		hasher.combine(children)

	}
}


