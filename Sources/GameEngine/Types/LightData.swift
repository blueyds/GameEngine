//
//  File.swift
//  
//
//  Created by Craig Nunemaker on 12/3/22.
//

import Foundation
import simd



public struct LightData: sizeable {
	public var position = Float3.zero
	public var color = Float3(1, 1, 1)
	public var brightness: Float = 1.0
	public var ambientIntensity: Float = 1.0
	public var diffuseIntensity: Float = 1.0
	public var specularIntensity: Float = 1.0
	public init(){	}
}
