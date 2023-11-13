//
//  Preferences.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit
import simd

public protocol MetalPreferences {
	var clearColor: MTLClearColor { get }
	var mainPixelFormat: MTLPixelFormat { get }
	var mainDepthPixelFormat: MTLPixelFormat { get }
}
