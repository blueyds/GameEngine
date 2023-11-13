//
//  MeshLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/28/22.
//

import MetalKit


public protocol Mesh {
	func setInstanceCount(_ count: Int)
	func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder)
}
