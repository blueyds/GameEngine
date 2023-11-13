

public struct Vertex: sizeable {
	public var position: float3
	public var color: GameColor
	public var textureCoordinate: float2
	public var normal: float3
	public init(position: float3,
				color: GameColor,
				textureCoordinate: float2,
				normal: float3){
		self.position = position
		self.color = color
		self.textureCoordinate = textureCoordinate
		self.normal = normal
	}

}