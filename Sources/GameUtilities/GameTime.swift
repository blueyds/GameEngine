
import Foundation


public class GameTime {
	private  var _lastUpdateTime: Date
    private  var _totalGameTime: TimeInterval
    private  var _deltaTime: TimeInterval
	public init() {
		_lastUpdateTime = Date()
		_totalGameTime = 0.0
		_deltaTime = 0.0
	}
    public func UpdateTime() {
		let now = Date()
		_deltaTime = now.timeIntervalSince(_lastUpdateTime)
		_totalGameTime += _deltaTime
		_lastUpdateTime = now
	}
}

extension GameTime {
    public var TotalGameTime: TimeInterval {
        _totalGameTime
    }

	    
    public var DeltaTime: TimeInterval {
        _deltaTime
    }
}
