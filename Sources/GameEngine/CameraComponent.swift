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
	
	public var viewMatrix: matrix_float4x4 {
		var viewMatrix = matrix_identity_float4x4
		
		if let node = entity as? GameNode {
			viewMatrix.rotate(angle: node.getRotationX(), axis: .x)
			viewMatrix.rotate(angle: node.getRotationY(), axis: .y)
			viewMatrix.rotate(angle: node.getRotationZ(), axis: .z)
			viewMatrix.translate(direction: -node.getPosition())
		}
		else {fatalError("error in camera component. it is not a node")}
		
		return viewMatrix
	}
	
	private var _fov: Float
	private var _aspectRation: Float
	private var _near: Float
	private var _far: Float

	
	public var projectionMatrix: matrix_float4x4 {
		return matrix_float4x4.perspective(degreesFov: _fov,
										   aspectRatio: _aspectRation,
										   near: _near,
										   far: _far)
	}
	
	public init(named cameraType: String, fov: Float, aspectRatio: Float, near: Float, far: Float){
		self.cameraName = cameraType
		self._fov = fov
		self._aspectRation = aspectRatio
		self._near = near
		self._far = far
		super.init()
	}
	
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setFov(fov: Float){
		_fov = fov
	}
	public func setAspectRation(_ ratio: Float){
		_aspectRation = ratio
	}
	public func setNear(_ near: Float){
		_near = near
	}
	public func setFar(_ far: Float){
		_far = far
	}
	
	
}

extension GameNode {
	public var Camera: CameraComponent? {
		component(ofType: CameraComponent.self)
	}
}
