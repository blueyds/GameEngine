import simd

public typealias floar2 = simd_float2
public typealias float3 = simd_float3
public typealias float4 = simd_float4
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
extension float2{
    public static var zero: float2{
        float2(0,0)
    }
    public static var one: float2{
        float2(1,1)
    }
}
extension float3{
    public static var zero: float3 {
        float3(0,0,0)
    }
    public static var one: float3 {
        float3(1,1,1)
    }
}
extension float4{
    public static var zero: floar4{
        float4(0,0,0,0)
    }
    public static var one: float4{
        float4(1,1,1,1)
    }
}

// Position extensions
extension simd_float3 {
	public mutating func moveX(_ delta: Float){ self.x += delta }
	public mutating func moveY(_ delta: Float){ self.y += delta }
	public mutating func moveZ(_ delta: Float){ self.z += delta }	
}
// Rotation extensions
extension simd_float3 {
	public mutating func rotateX(by delta: Float){ self.x += delta }
	public mutating func rotateY(by delta: Float){ self.y += delta }
	public mutating func rotateZ(by delta: Float){ self.z += delta }
}
// Scale extensions
extension simd_float3 {
	public mutating func scaleX(by delta: Float){ self.x += delta }
	public mutating func scaleY(by delta: Float){ self.y += delta }
	public mutating func scaleZ(by delta: Float){ self.z += delta }
}
// RGB extensions
extension simd_float3 {
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
extension simd_float4 {
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