import MetalKit


open class CustomMesh: Mesh {
	private var _vertexBuffer: MTLBuffer!
	private var _vertices: [Vertex] = []
	public var vertexCount: Int!{
		_vertices.count
	}
	var instanceCount: Int = 1
    private var _color: GameColor

    
	public init(color: GameColor = .black) {
        _color = color
		createVertices()
		createBuffers()
	}
	open func createVertices() {	}
	
	public func addVertex(position: Float3,
				   textureCoordinates: Float2 = Float2.zero,
				   normal: Float3 = Float3(0,1,0)){
		_vertices.append(Vertex(position: position, color: _color.vector, textureCoordinate: textureCoordinates, normal: normal))
	}
	func createBuffers(){
		_vertexBuffer = GlobalEngine.device.makeBuffer(bytes: _vertices, length: Vertex.stride(_vertices.count) )
	}
	public func setInstanceCount(_ count: Int) {
		instanceCount = count
	}
	open func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder){
		renderCommandEncoder.setVertexBuffer(_vertexBuffer, offset: 0, index: 0)
		if instanceCount == 1 {
			renderCommandEncoder.drawPrimitives(type: .triangle,
												vertexStart: 0,
												vertexCount: vertexCount)
		} else {
			renderCommandEncoder.drawPrimitives(type: .triangle,
												vertexStart: 0,
												vertexCount: vertexCount,
												instanceCount: instanceCount)
		}
	}
	
}
