import Foundation
import simd

public struct Material: sizeable {
	public var color = Color
	public var useMaterialColor = false
	public var useTexture: Bool = false
	public var isLit: Bool = true
	public var ambient: ColorRGB = ColorRGB(r: 0.1, g: 0.1, b: 0.1)
	public var diffuse: ColorRGB = ColorRGB(r: 1, g: 1, b: 1)
	public var specular: ColorRGB = ColorRGB(r: 1, g: 1, b: 1)
	public var shininess: Float = 50
	public init(){ }
	public func setMaterialColor(_ color: simd_float4){
		self.color.r = color
		useMaterialColor = true
		useTexture = false
	}
 }