import Node

public struct CallbackClaim: EqualityClaim, StringBacked {
    public static var name = "callback"
    
    public let value: String
    
    public init(string: String) {
        self.value = string
    }
}
