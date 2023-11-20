import simd
import Metal

public struct GameColor: sizeable{
    public var r: Float
    public var g: Float
    public var b: Float
    public var a: Float
    
    init(_ r: Float, _ g: Float, _ b: Float, _ a:Float ){
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }
    public var vector: Float4 {
        Float4(r, g, b, a)
    }
	public var float3: Float3 {
		Float3(r, g, b)
	}
    public var clearColor: MTLClearColor{
        MTLClearColorMake(Double(r), Double(g), Double(b), Double(a))
    }
    static public func black(a: Float = 1)-> GameColor{ GameColor(0,0,0,a)}
    static public func navy(a: Float = 1)-> GameColor { GameColor(0,0,0.5,a)}
    static public func blue(a: Float = 1)-> GameColor { GameColor(0,0,1,a)}
    static public func green(a: Float = 1)-> GameColor { GameColor(0, 0.5, 0, a)}
    static public func teal(a: Float = 1)-> GameColor { GameColor(0, 0.5, 0.5, a)}
    static public func lime(a: Float = 1)-> GameColor { GameColor(0, 1, 0, a)}
    static public func aqua(a: Float = 1 ) -> GameColor { GameColor(0, 1, 1, a)}
    static public func maroon(a: Float = 1) -> GameColor { GameColor(0.5, 0, 0, a)}
    static public func purple(a: Float = 1) -> GameColor { GameColor(0.5, 0, 0.5, a)}
    static public func olive(a: Float = 1) -> GameColor { GameColor(0.5, 0.5, 0, a)}
    static public func gray(a: Float = 1) -> GameColor { GameColor(0.5, 0.5, 0.5, a)}
    static public func silver(a: Float = 1) -> GameColor { GameColor(0.75, 0.75, 0.75, a)}
    static public func red(a: Float = 1) -> GameColor { GameColor(1, 0, 0, a)}
    static public func fuchsia(a: Float = 1) -> GameColor { GameColor(1, 0, 1, a)}
    static public func yellow(a: Float = 1) -> GameColor { GameColor(1, 1, 0, a)}
    static public func white(a: Float = 1) -> GameColor { GameColor(1, 1, 1, a)}
    
    static public func randomColor()->GameColor{
        let a: Float = Float.random(in: 0...1)
        let i = Int.random(in: 1...16)
        switch i {
        case 1: return GameColor.black(a: a)
        case 2: return GameColor.navy(a: a)
        case 3: return GameColor.blue(a: a)
        case 4: return GameColor.green(a: a)
        case 5: return GameColor.teal(a: a)
        case 6: return GameColor.lime(a: a)
        case 7: return GameColor.aqua(a: a)
        case 8: return GameColor.maroon(a: a)
        case 9: return GameColor.purple(a: a)
        case 10: return GameColor.olive(a: a)
        case 11: return GameColor.gray(a: a)
        case 12: return GameColor.silver(a: a)
        case 13: return GameColor.red(a: a)
        case 14: return GameColor.fuchsia(a: a)
        case 15: return GameColor.yellow(a: a)
        case 16: return GameColor.white(a: a)
        default: return GameColor.black(a: a)
        }
    }
}
