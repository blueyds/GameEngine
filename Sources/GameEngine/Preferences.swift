//
//  Preferences.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 4/23/22.
//

import MetalKit


public class Preferences {
	public enum ClearColors{
		static let White = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		static let Green = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1.0)
		static let Grey = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
		static let DarkGrey = MTLClearColor(red: 0.01, green: 0.01, blue: 0.01, alpha: 1)
		static let Black = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		static let LimeGreen = MTLClearColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1)
	}
	
	public static let shared: Preferences = Preferences()
	//MARK: change these to vars so we can change
	public let clearColor: MTLClearColor = ClearColors.DarkGrey
	public let mainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm_srgb
	public let mainDepthPixelFormat: MTLPixelFormat = MTLPixelFormat.depth32Float
	public let framesPerSEcond: Int = 60
	// MARK: do we oneed this in the framework
	
//	public var startingSceneType: SceneManager.Types = .Sandbox
	private init(){
		
	}
}
