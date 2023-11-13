import MetalKit

public class Cube_CustomMesh: CustomMesh {
	public override func createVertices() {
		//Left
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		addVertex(position: Float3(-1.0,-1.0, 1.0))
		addVertex(position: Float3(-1.0, 1.0, 1.0))
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		addVertex(position: Float3(-1.0, 1.0, 1.0))
		addVertex(position: Float3(-1.0, 1.0,-1.0))
		
		//RIGHT
		addVertex(position: Float3( 1.0, 1.0, 1.0))
		addVertex(position: Float3( 1.0,-1.0,-1.0))
		addVertex(position: Float3( 1.0, 1.0,-1.0))
		addVertex(position: Float3( 1.0,-1.0,-1.0))
		addVertex(position: Float3( 1.0, 1.0, 1.0))
		addVertex(position: Float3( 1.0,-1.0, 1.0))
		
		//TOP
		addVertex(position: Float3( 1.0, 1.0, 1.0))
		addVertex(position: Float3( 1.0, 1.0,-1.0))
		addVertex(position: Float3(-1.0, 1.0,-1.0))
		addVertex(position: Float3( 1.0, 1.0, 1.0))
		addVertex(position: Float3(-1.0, 1.0,-1.0))
		addVertex(position: Float3(-1.0, 1.0, 1.0))
		
		//BOTTOM
		addVertex(position: Float3( 1.0,-1.0, 1.0))
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		addVertex(position: Float3( 1.0,-1.0,-1.0))
		addVertex(position: Float3( 1.0,-1.0, 1.0))
		addVertex(position: Float3(-1.0,-1.0, 1.0))
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		
		//BACK
		addVertex(position: Float3( 1.0, 1.0,-1.0))
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		addVertex(position: Float3(-1.0, 1.0,-1.0))
		addVertex(position: Float3( 1.0, 1.0,-1.0))
		addVertex(position: Float3( 1.0,-1.0,-1.0))
		addVertex(position: Float3(-1.0,-1.0,-1.0))
		
		//FRONT
		addVertex(position: Float3(-1.0, 1.0, 1.0))
		addVertex(position: Float3(-1.0,-1.0, 1.0))
		addVertex(position: Float3( 1.0,-1.0, 1.0))
		addVertex(position: Float3( 1.0, 1.0, 1.0))
		addVertex(position: Float3(-1.0, 1.0, 1.0))
		addVertex(position: Float3( 1.0,-1.0, 1.0))
	}

}
