import Node

// Should validate that it is a known type

public struct TypeClaim: EqualityClaim, StringBacked {
    public static var name = "type"
    
    public let value: String
    
    public init(string: String) {
        self.value = string
    }
}
