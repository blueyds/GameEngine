import MetalKit

public class RenderPipelineLibrary {

	private var _engine: EngineProtocol? = nil
	private let _device: MTLDevice
	private var _renderPipelineStates: [ String : MTLRenderPipelineState] = [:]
	private var _pixelFormat: MTLPixelFormat? = nil
	private var _depthFormat: MTLPixelFormat? = nil
	
	public init(device: MTLDevice){
		self._device = device
	}
	
	public init(device: MTLDevice, pixelFormat: MTLPixelFormat, depthPixelFormat: MTLPixelFormat){
		self._device = device
		self._pixelFormat = pixelFormat
		self._depthFormat = depthPixelFormat
	}
	public subscript(name: String)->MTLRenderPipelineState?{
		_renderPipelineStates[name]
	}

	public func setEngine(_ engine: EngineProtocol){
		_engine = engine
	}
	public func addState(named name: String,
						   renderDescriptor: MTLRenderPipelineDescriptor) {
		do{
			let rps = try _device.makeRenderPipelineState(descriptor: renderDescriptor)
			//let renderState = RenderPipelineState(name: name, state: rps)
			_renderPipelineStates.updateValue(rps, forKey: name)
//		}
		}catch let error as NSError {
			print("ERROR Creating Render Pipeline State for \(name) error = \(error)")
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
	public func addState(named name: String,
						 vertexFnNamed: String,
						 fragmentFnNamed: String,
						 vertexDescriptorNamed: String){
		guard let shaders = _engine?.shaders else { return }
		guard let descriptors = _engine?.descriptors else { return }
		guard let pixelFormat = _pixelFormat else { return }
		guard let depthFormat = _depthFormat else { return }
		guard let vertex = shaders[vertexFnNamed, .vertex] else { return }
		guard let fragment = shaders[fragmentFnNamed, .fragment] else { return }
		guard let descriptor = descriptors[vertexDescriptorNamed] else { return }
		let renderDescriptor = createDescriptor(pixelFormat: pixelFormat, depthPixelFormat: depthFormat, vertexFunction: vertex, fragmentFunction: fragment, vertexDescriptor: descriptor)
		addState(named: name, renderDescriptor: renderDescriptor)
	}

	public func createDescriptor(
		pixelFormat: MTLPixelFormat,
		depthPixelFormat: MTLPixelFormat,
		vertexFunction: MTLFunction,
		fragmentFunction: MTLFunction,
		vertexDescriptor: MTLVertexDescriptor) -> MTLRenderPipelineDescriptor	{
			let descriptor = MTLRenderPipelineDescriptor()
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
