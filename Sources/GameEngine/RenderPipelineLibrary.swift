import MetalKit

public class RenderPipelineLibrary {
//	public enum Types{
//		case Basic
//		case Instanced
//	}
	private let _engine: EngineProtocol
	private var _renderPipelineStates: [ RenderPipelineState] = []
	
	public init(engine: EngineProtocol){
		self._engine = engine
	}
	subscript(name: String)->MTLRenderPipelineState?{
		_renderPipelineStates.first(where: {$0.name == name })?.state
	}
	public func addState(named name: String,
						   renderDescriptor: MTLRenderPipelineDescriptor) {
		do{
			let rps = try _engine.device.makeRenderPipelineState(descriptor: renderDescriptor)
			let renderState = RenderPipelineState(name: name, state: rps)
			_renderPipelineStates.append(renderState)

		}catch let error as NSError {
			print("ERROR Creating Render Pipeline State for \(name) error = \(error)")
		}
	}
	public func addState(named name: String,
						 pixelFormat: MTLPixelFormat,
						 depthPixelFormat: MTLPixelFormat,
						 vertexFunction: String,
						 fragmentFunction: String,
						 vertexDescriptorType: String){
		addState(named: name,
				 renderDescriptor: createDescriptor(
					pixelFormat: pixelFormat,
					depthPixelFormat: depthPixelFormat,
					vertexFunction: vertexFunction,
					fragmentFunction: fragmentFunction,
					vertexDescriptorType: vertexDescriptorType))
	}
	public func createDescriptor(
	
		pixelFormat: MTLPixelFormat,
		depthPixelFormat: MTLPixelFormat,
		vertexFunction: String,
		fragmentFunction: String,
		vertexDescriptorType: String)->MTLRenderPipelineDescriptor!	{
			let descriptor: MTLRenderPipelineDescriptor! = MTLRenderPipelineDescriptor()
			descriptor.colorAttachments[0].pixelFormat = pixelFormat
			descriptor.depthAttachmentPixelFormat = depthPixelFormat
			descriptor.vertexFunction = _engine.shaders[vertexFunction]!
			descriptor.fragmentFunction = _engine.shaders[fragmentFunction]!
			descriptor.vertexDescriptor = _engine.descriptors[vertexDescriptorType]!
			return descriptor
	}
	
}

public class RenderPipelineState{
	public var name: String
	public var state: MTLRenderPipelineState
	public init (name: String, state: MTLRenderPipelineState){
		self.name = name
		self.state = state
	}
}
