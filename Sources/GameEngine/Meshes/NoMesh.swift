//
//  NoMesh.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//

import MetalKit

public class NoMesh: Mesh {
	public func setInstanceCount(_ count: Int) {}
	
	public func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder) {}
	
}
