import MetalKit


open class CustomMesh: Mesh {
	private var _vertexBuffer: MTLBuffer!
	private var _vertices: [Vertex] = []
	public var vertexCount: Int!{
		_vertices.count
	}
	var instanceCount: Int = 1
	static var Engine: EngineProtocol? = nil
	public init() {
		if CustomMesh.Engine == nil {
			fatalError("MeshComponent.Engine should be initialized before any meshes")
		}
		createVertices()
		createBuffers()
	}
	open func createVertices() {	}
	
	public func addVertex(position: simd_float3,
				   color: simd_float4 = simd_float4(1,0,1,1),
				   textureCoordinates: simd_float2 = simd_float2(repeating: 0),
				   normal: simd_float3 = simd_float3(0,1,0)){
		_vertices.append(Vertex(position: position, color: color, textureCoordinate: textureCoordinates, normal: normal))
	}
	func createBuffers(){
		_vertexBuffer = CustomMesh.Engine!.device.makeBuffer(bytes: _vertices, length: Vertex.stride(_vertices.count) )
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
