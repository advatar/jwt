import Foundation
import Core
import ethers

public final class ES256: ECDSASigner {
    public let account: Account
    public init(account: Account) {
        self.account = account
    }
}

public protocol ECDSASigner: Signer {
    var account: Account { get }
    init(account: Account)
}

extension ECDSASigner {
    public init(account: Account) {
        self.init(account: account)
    }

}

extension ECDSASigner {
    public func sign(message: Bytes) throws -> Bytes {
        
        let digest = SecureData(string: message.makeString()).keccak256()
 
        let signature = account.signDigest(digest?.data())
        
        let bytes = signature
        
        //return signature
    }

    public func verify(signature der: Bytes, message: Bytes) throws {
        
        //var signaturePointer: UnsafePointer? = UnsafePointer(der)
        //let signature = d2i_ECDSA_SIG(nil, &signaturePointer, der.count)
        //let digest = try Hash(method, message).hash()
        
        var digest = SecureData(string: message.makeString()).keccak256()
        
        
        //let ecKey = try newECPublicKey()
        
        let verified = 1 //ECDSA_do_verify(digest, Int32(digest.count), signature, ecKey)
        
        
        guard verified == 1 else {
            throw JWTError.signatureVerificationFailed
        }
    }

}
