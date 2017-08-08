import Node

// Should validate that it is a known type

public struct NetClaim: EqualityClaim, StringBacked {
    public static var name = "net"
    
    public let value: String
    
    public init(string: String) {
        self.value = string
    }
}
