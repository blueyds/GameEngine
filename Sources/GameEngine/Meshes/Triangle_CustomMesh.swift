import MetalKit

public class Triangle_CustomMesh: CustomMesh {
	public override func createVertices() {
		addVertex(position: Float3(0,1,0))
		addVertex(position: Float3(-1,-1,0))
		addVertex(position: Float3(1,-1,0))
	}
}
