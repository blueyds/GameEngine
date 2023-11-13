import simd

public typealias Float2 = simd_float2
public typealias Float3 = simd_float3
public typealias Float4 = simd_float4
extension Float {
	public var toRadians: Float{
		(self / 100.0) * Float.pi
	}
	
	public var toDegrees: Float {
		self * (100.0 / Float.pi)
	}
	
	public static var randomZeroToOne: Float {
		return Float(arc4random()) / Float(UINT32_MAX)
	}
}
extension Float2{
    public static var zero: Float2{
        Float2(0,0)
    }
    public static var one: Float2{
        Float2(1,1)
    }
}
extension Float3{
    public static var zero: Float3 {
        Float3(0,0,0)
    }
    public static var one: Float3 {
        Float3(1,1,1)
    }
}
extension Float4{
    public static var zero: Float4{
        Float4(0,0,0,0)
    }
    public static var one: Float4{
        Float4(1,1,1,1)
    }
}

// Position extensions
extension Float3 {
	public mutating func moveX(_ delta: Float){ self.x += delta }
	public mutating func moveY(_ delta: Float){ self.y += delta }
	public mutating func moveZ(_ delta: Float){ self.z += delta }	
}
// Rotation extensions
extension Float3 {
	public mutating func rotateX(by delta: Float){ self.x += delta }
	public mutating func rotateY(by delta: Float){ self.y += delta }
	public mutating func rotateZ(by delta: Float){ self.z += delta }
}
// Scale extensions
extension Float3 {
	public mutating func scaleX(by delta: Float){ self.x += delta }
	public mutating func scaleY(by delta: Float){ self.y += delta }
	public mutating func scaleZ(by delta: Float){ self.z += delta }
}
// RGB extensions
extension Float3 {
	var r: Float { 
		get { self.x }
		set { self.x = newValue }
	}
	var g: Float {
		get { self.y }
		set {  self.y = newValue }
	}
	var b: Float {
		get { self.z }
		set { self.z = newValue }
	}
	init(r: Float, g: Float, b: Float){
		self.init(r, g, b)
	}
}
// RGBA extensions
extension Float4 {
	var r: Float { 
		get { self.x }
		set { self.x = newValue }
	}
	var g: Float {
		get { self.y }
		set {  self.y = newValue }
	}
	var b: Float {
		get { self.z }
		set { self.z = newValue }
	}
	var a: Float {
		get { self.w }
		set { self.w = newValue }
	}
	init(r: Float, g: Float, b: Float, a: Float){
		self.init(r, g, b, a)
	}
}