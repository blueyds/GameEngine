//
//  TextureLibrary.swift
//  GameEngineMetal
//
//  Created by Craig Nunemaker on 5/7/22.
//

import MetalKit

//public class TextureLibrary {
//	public enum Types {
//		case None
//		case PartyPirateParot
//		case Cruiser
//	}
//	let _device: MTLDevice
//	private var _textures: [Types : Texture] = [:]
//	
//	public init (device: MTLDevice) {
//		_device = device
//		createDefaultTextures()
//	}
//	private func createDefaultTextures(){
//		addTexture(name: "PartyPirateParot", forKey: .PartyPirateParot)
//		addTexture(name: "cruiser", ext: "bmp", origin: .bottomLeft, forKey: .Cruiser)
//	}
//	private func addTexture(name: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft, forKey: Types){
//		_textures.updateValue(Texture(name, ext: ext, origin: origin, device: _device), forKey: forKey )
//	}
//	public subscript (_ type: Types) -> MTLTexture? {
//		return _textures[type]?.texture
//	}
//}

public class Texture {
	var texture: MTLTexture!
	
	public init(name: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft, device: MTLDevice = MetalEngine.shared.device){
		let textureLoader = TextureLoader(textureName: name, textureExtension: ext, origin: origin, device: device)
		let texture: MTLTexture = textureLoader.loadTextureFromBundle()
		setTexture(texture)
	}
	
	public func setTexture(_ texture: MTLTexture){
		self.texture = texture
	}
}
class TextureLoader {
	private var _textureName: String!
	private var _textureExtension: String!
	private var _origin: MTKTextureLoader.Origin!
	let _device: MTLDevice
	
	init(textureName: String, textureExtension: String = "png", origin: MTKTextureLoader.Origin = .topLeft, device: MTLDevice){
		self._textureName = textureName
		self._textureExtension = textureExtension
		self._origin = origin
		self._device = device
	}
	
	func loadTextureFromBundle()->MTLTexture{
		var result: MTLTexture!
		if let url = Bundle.main.url(forResource: _textureName, withExtension: self._textureExtension) {
			let textureLoader = MTKTextureLoader(device: _device)
			
			let options: [MTKTextureLoader.Option : MTKTextureLoader.Origin] = [MTKTextureLoader.Option.origin : _origin]
			
			do{
				result = try textureLoader.newTexture(URL: url, options: options)
				result.label = _textureName
			}catch let error as NSError {
				print("ERROR::CREATING::TEXTURE::__\(_textureName!)__::\(error)")
			}
		}else {
			print("ERROR::CREATING::TEXTURE::__\(_textureName!) does not exist")
		}
		
		return result
	}
}
