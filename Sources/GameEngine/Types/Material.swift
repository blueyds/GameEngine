import Foundation
import simd

public struct Material: sizeable {
	public var color = Float4(r: 0, g: 0, b: 0, a: 1)
	public var useMaterialColor = false
	public var useTexture: Bool = false
	public var isLit: Bool = false
	public var ambient = Float3(r: 0.1, g: 0.1, b: 0.1)
	public var diffuse = Float3(r: 1, g: 1, b: 1)
	public var specular = Float3(r: 1, g: 1, b: 1)
	public var shininess: Float = 50
	public init(){  }
	public init(color: GameColor){
		self.color = color.vector
		useMaterialColor = true
		useTexture = false
		isLit = false
	}
	public init(color: GameColor, ambient: Float, diffuse: Float, specular: Float, shininess: Float){
		self.color = color.vector
		useMaterialColor = true
		useTexture = false
		isLit = true
		self.ambient = Float3(repeating: ambient)
		self.diffuse = Float3(repeating: diffuse)
		self.specular = Float3(repeating: specular)
		self.shininess = shininess
	}
}
