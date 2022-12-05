import MetalKit

public class RenderPipelineLibrary {
//	public enum Types{
//		case Basic
//		case Instanced
//	}
	private let _device: MTLDevice
	private var _renderPipelineStates: [ String : MTLRenderPipelineState] = [:]
	
	public init(device: MTLDevice){
		self._device = device
	}
	public subscript(name: String)->MTLRenderPipelineState?{
		_renderPipelineStates[name]
	}
	public func addState(named name: String,
						   renderDescriptor: MTLRenderPipelineDescriptor) {
		if let rps = _device.makeRenderPipelineState(descriptor: renderDescriptor){
			_renderPipelineStates.updateValue(rps, forKey: name)
		}
	}
	public func addState(named name: String,
						 pixelFormat: MTLPixelFormat,
						 depthPixelFormat: MTLPixelFormat,
						 vertexFunction: MTLFunction,
						 fragmentFunction: MTLFunction,
						 vertexDescriptor: MTLVertexDescriptor){
		addState(named: name,
				 renderDescriptor: createDescriptor(
					pixelFormat: pixelFormat,
					depthPixelFormat: depthPixelFormat,
					vertexFunction: vertexFunction,
					fragmentFunction: fragmentFunction,
					vertexDescriptor: vertexDescriptor))
	}
	public func createDescriptor(
	
		pixelFormat: MTLPixelFormat,
		depthPixelFormat: MTLPixelFormat,
		vertexFunction: MTLFunction,
		fragmentFunction: MTLFunction,
		vertexDescriptor: MTLVertexDescriptor)->MTLRenderPipelineDescriptor!	{
			let descriptor: MTLRenderPipelineDescriptor! = MTLRenderPipelineDescriptor()
			descriptor.colorAttachments[0].pixelFormat = pixelFormat
			descriptor.depthAttachmentPixelFormat = depthPixelFormat
			descriptor.vertexFunction = vertexFunction
			descriptor.fragmentFunction = fragmentFunction
			descriptor.vertexDescriptor = vertexDescriptor
			return descriptor
	}
	
}
//
//public class RenderPipelineState{
//	public var name: String
//	public var state: MTLRenderPipelineState
//	public init (name: String, state: MTLRenderPipelineState){
//		self.name = name
//		self.state = state
//	}
//}
