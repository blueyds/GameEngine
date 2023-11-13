

public struct Vertex: sizeable {
	public var position: Float3
	public var color: Float4
	public var textureCoordinate: Float2
	public var normal: Float3
	public init(position: Float3,
				color: Float4,
				textureCoordinate: Float2,
				normal: Float3){
		self.position = position
		self.color = color
		self.textureCoordinate = textureCoordinate
		self.normal = normal
	}

}