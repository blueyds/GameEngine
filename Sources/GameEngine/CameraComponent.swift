//
//  CameraComponent.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/21/22.
//
import MetalKit
import GameplayKit


public class CameraComponent: GKComponent {
	var cameraName: String
	public weak var node: GameNode {
		if let n = entity as? GameNode{
			return n
		} else {
			fatalError("error in camera component. it is not a node")
		}
	}
	public var viewMatrix: matrix_float4x4 {
		var viewMatrix = matrix_identity_float4x4
		viewMatrix.rotate(angle: node.rotation.x, axis: .x)
		viewMatrix.rotate(angle: node.rotation.y, axis: .y)
		viewMatrix.rotate(angle: node.rotation.z, axis: .z)
		viewMatrix.translate(direction: -node.position)
		
		return viewMatrix
	}
	public var position: simd_float3 {
		node!.position
	}
	public var fov: Float
	public var aspectRatio: Float
	public var near: Float
	public var far: Float

	
	public var projectionMatrix: matrix_float4x4 {
		return matrix_float4x4.perspective(degreesFov: fov,
										   aspectRatio: aspectRatio,
										   near: near,
										   far: far)
	}
	
	public init(named cameraType: String, fov: Float, aspectRatio: Float, near: Float, far: Float){
		self.cameraName = cameraType
		self.fov = fov
		self.aspectRatio = aspectRatio
		self.near = near
		self.far = far
		super.init()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	public func setAspectRatio(screenSize: CGSize){
        self.aspectRatio = Float(screenSize.width) / Float(screenSize.height)
    }
    public func setAspectRatio(width: Float, height: Float){
    	self.aspectRatio = width / height
    }
	
}

extension GameNode {
	public var Camera: CameraComponent? {
		component(ofType: CameraComponent.self)
	}
}
