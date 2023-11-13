import Foundation


extension TimeInterval {
 public var Milliseconds: Int{
	 return Int((self * 1000).rounded())
 }
 public var RatePerSecond:Float {
//	 let v1 = self.Milliseconds
//
//	 let v3  = 1 / v2
//	 return v3
	 return 1
	}
}