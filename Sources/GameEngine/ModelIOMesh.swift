import ModelIO
import MetalKit

open class ModelIOMesh: Mesh {
    public var instanceCount: Int = 1
    public var mesh: MTKMesh? = nil
    public static var Engine: EngineProtocol? = MeshComponent.Engine
    
    init(){
        if ModelIOMesh.Engine == nil {
            fatalError("MeshCompjononet engine should be initialized before meshes")
        }
        // let allocator = MTKMeshBufferAllocator(device: myMetalDevice)
        // let mdlMesh = MDLMesh(scnGeometry: sceneGeometry, bufferAllocator: allocator)
        //  let mtkMesh = try! MTKMesh(mesh: mdlMesh, device: myMetalDevice)
        //            ~~~~ <- in real code, please handle errors
        
    }
    public func setInstanceCount(_ count: Int){
        instanceCount = count
    }
    
    
    public func drawPrimitives(_ renderCommandEncoder: MTLRenderCommandEncoder){
        if mesh == nil {
            return
        }
        var index = 0
        for submesh in mesh!.submeshes {
            // submesh is a MTKSubmesh, containing an MTKMeshBuffer
            // set the vertex buffer for this submesh
            if let vertexBuffer = mesh?.vertexBuffers[index]{
                renderCommandEncoder.setVertexBuffer(
                    vertexBuffer.buffer,
                    offset: vertexBuffer.offset, 
                    index: 0)
            }
            if instanceCount == 1 {
                renderCommandEncoder.drawIndexedPrimitives(
                    type: submesh.primitiveType, 
                    indexCount: submesh.indexCount, 
                    indexType: submesh.indexType, 
                    indexBuffer: submesh.indexBuffer.buffer, 
                    indexBufferOffset: submesh.indexBuffer.offset)
            } else {
                renderCommandEncoder.drawIndexedPrimitives(
                    type: submesh.primitiveType,
                    indexCount: submesh.indexCount,
                    indexType: submesh.indexType,
                    indexBuffer: submesh.indexBuffer.buffer,
                    indexBufferOffset: submesh.indexBuffer.offset,
                    instanceCount: instanceCount)    
            }
            index += 1
        }
    }
}
// then, at render time...
