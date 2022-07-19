//
//  GameNodeBuilder.swift
//  Craigs Engine
//
//  Created by Craig Nunemaker on 6/10/22.
//

//import Darwin

//import Foundation

@resultBuilder
public struct GameNodeBuilder {
	public static func buildBlock(_ components: GameNode...) -> [GameNode] {
		components
	}
}

