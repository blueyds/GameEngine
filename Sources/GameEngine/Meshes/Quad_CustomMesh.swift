import MetalKit

public class Quad_CustomMesh: CustomMesh {
	public override func createVertices() {
		addVertex(position: Float3(1,1,0), textureCoordinates: Float2(1,0))
		addVertex(position: Float3(-1,1,0), textureCoordinates: Float2(0,0))
		addVertex(position: Float3(-1,-1,0),textureCoordinates: Float2(0,1))
		addVertex(position: Float3(1,1,0), textureCoordinates: Float2(1,0))
		addVertex(position: Float3(-1,-1,0),textureCoordinates: Float2(0,1))
		addVertex(position: Float3(1,-1,0), textureCoordinates: Float2(1,1))
	}
}
