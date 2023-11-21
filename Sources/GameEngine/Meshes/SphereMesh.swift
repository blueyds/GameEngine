import MetalKit
import ModelIO

public class Sphere: ModelIOMesh {
    // the more segments the more detailed sphere will be
    // anything less than 22 may not look right
    
    public init(segments: UInt32 = 30){
        super.init()
        let allocator = MTKMeshBufferAllocator(device: GlobalEngine.device)
        let mdlMesh = MDLMesh(
            sphereWithExtent: vector_float3(1,1,1), 
            segments: vector_uint2(repeating: segments), 
            inwardNormals: false, 
            geometryType: .triangles, 
            allocator: allocator)
        do{
            self.mesh = try MTKMesh(mesh: mdlMesh, device: GlobalEngine.device)
        } catch  {
            print("error initializing SPhere mesh for object. Error is: \(error)")
        }
        assert(self.mesh?.submeshes.count == self.mesh?.vertexBuffers.count)
    }
}
