//
//  NoMesh.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit

class NoMesh: Mesh {
	func setInstanceCount(_ count: Int) {}
	
	func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {}
	
}
