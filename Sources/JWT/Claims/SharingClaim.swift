import Foundation
import Node

public struct SharingClaim: NodeFailableInitializable {
    fileprivate let value: Set<String>

    public init(string: String) {
        self.value = [string]
    }

    public init(strings: Set<String>) {
        self.value = strings
    }

    public init?(_ node: Node) {
        if let string = node.string {
            self.init(string: string)
        } else if let array = node.array?.flatMap({ $0.string }) {
            self.init(strings: Set(array))
        } else {
            return nil
        }
    }
}

public struct OwnInfoClaim:  NodeFailableInitializable {
    
    fileprivate let value:Node
    
    public init?(_ node: Node) {
        self.value = node
    }
}
/*
extension OwnInfoClaim: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(string: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(string: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(string: value)
    }
}

extension OwnInfoClaim: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: String...) {
        self.init(strings: Set(elements))
    }
}
*/

extension OwnInfoClaim: Claim {
    
    public static let name = "own"
    
    public func verify(_ node: Node) -> Bool {
        guard let other = OwnInfoClaim(node) else {
            return false
        }
        return true
        //return value.intersection(other.value).count == other.value.count
    }
    
    public var node: Node {
        return value
    }
}


extension SharingClaim: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(string: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(string: value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(string: value)
    }
}

extension SharingClaim: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: String...) {
        self.init(strings: Set(elements))
    }
}


extension SharingClaim: Claim {
    public static let name = "requested"

    public func verify(_ node: Node) -> Bool {
        guard let other = SharingClaim(node) else {
            return false
        }

        return value.intersection(other.value).count == other.value.count
    }

    public var node: Node {
        let strings = value.array.map(StructuredData.string)
        return Node(
            .array(strings),
            in: nil
        )
    }
}
