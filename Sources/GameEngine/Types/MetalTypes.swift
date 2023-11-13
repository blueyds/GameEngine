//
//  Types.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import simd
import Foundation

public struct ModelConstants: sizeable {
	public var modelMatrix = Matrix.identity
}

public struct SceneConstants:sizeable {
	public var totalGameTime: Float = 0
	public var viewMatrix = Matrix.identity
	public var projectionMatrix = Matrix.identity
	public var cameraPosition = Float3.zero
}

