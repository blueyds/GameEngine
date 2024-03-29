

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
	public static var descriptor: VertexDescriptor{
		VertexDescriptor(
            attributes: [
                VertexDescriptor.Attribute(position: 0, format: .float3, offset: 0, bufferIndex: 0), // position
                VertexDescriptor.Attribute(position: 1, format: .float4, offset: Float3.size, bufferIndex: 0), // color 
                VertexDescriptor.Attribute(position: 2, format: .float2, offset: Float3.size + Float4.size, bufferIndex: 0), // texture
                VertexDescriptor.Attribute(position: 3, format: .float3, offset: Float3.size + Float4.size + Float2.size, bufferIndex: 0) // normal
            ], 
            layouts: [
                VertexDescriptor.Layout(stride: Vertex.stride)
            ])
	}

}