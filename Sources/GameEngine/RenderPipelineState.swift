import MetalKit

public class RenderPipelineLibrary {
	public enum Types{
		case Basic
		case Instanced
	}
	private let device: MTLDevice!
	private let _library: ShaderLibrary
	private let _vertexDescriptor: VertexDescriptorLibrary
	private let _preferences: Preferences
	
	private var _renderPipelineStates: [Types: RenderPipelineState] = [:]
	
	public init(device: MTLDevice!,library: ShaderLibrary, vertexDescriptorLibrary: VertexDescriptorLibrary, preferences: Preferences){
		self.device = device
		self._library = library
		self._vertexDescriptor = vertexDescriptorLibrary
		self._preferences = preferences
		createDefaultStates()
	}
	public func renderState(_ renderStateType: Types)-> MTLRenderPipelineState{
		_renderPipelineStates[renderStateType]!.state
	}
	
	public func createDefaultStates(){
		createState("Basic Render State",
					renderDescriptor: createDescriptor(
						pixelFormat: _preferences.mainPixelFormat,
						depthPixelFormat: _preferences.mainDepthPixelFormat,
						vertexFunction: .Basic,
						fragmentFunction: .Basic,
						vertexDescriptorType: .Basic),
					forKey: .Basic)
		createState("Instanced Render State",
					renderDescriptor: createDescriptor(
						pixelFormat: _preferences.mainPixelFormat,
						depthPixelFormat: _preferences.mainDepthPixelFormat,
						vertexFunction: .Instanced,
						fragmentFunction: .Basic,
						vertexDescriptorType: .Basic),
					forKey: .Instanced)
		
	}
	public func createState(_ name: String,
						   renderDescriptor: MTLRenderPipelineDescriptor,
						   forKey: Types) {
		do{
			let rps = try device.makeRenderPipelineState(descriptor: renderDescriptor)
			let renderState = RenderPipelineState(name: name, state: rps)
			_renderPipelineStates.updateValue(renderState, forKey: forKey)
		}catch let error as NSError {
			print("ERROR Creating Render Pipeline State for \(name) error = \(error)")
		}
	}
	public func createDescriptor(
	
		pixelFormat: MTLPixelFormat,
		depthPixelFormat: MTLPixelFormat,
		vertexFunction: ShaderLibrary.VertexShaderTypes,
		fragmentFunction: ShaderLibrary.FragmentShaderTypes,
		vertexDescriptorType: VertexDescriptorLibrary.Types)->MTLRenderPipelineDescriptor!	{
			let descriptor: MTLRenderPipelineDescriptor! = MTLRenderPipelineDescriptor()
			descriptor.colorAttachments[0].pixelFormat = pixelFormat
			descriptor.depthAttachmentPixelFormat = depthPixelFormat
			descriptor.vertexFunction = _library.Vertex(vertexFunction)
			descriptor.fragmentFunction = _library.Fragment(fragmentFunction)
			descriptor.vertexDescriptor = _vertexDescriptor.descriptor(vertexDescriptorType)
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
