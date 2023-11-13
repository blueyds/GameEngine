//
//  Types.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import simd
import Foundation

public struct ModelConstants: sizeable {
	public var modelMatrix = matrix.identity
}

public struct SceneConstants:sizeable {
	public var totalGameTime: Float = 0
	public var viewMatrix = matrix.identity
	public var projectionMatrix = matrix.identity
	public var cameraPosition = float3.zero
}

