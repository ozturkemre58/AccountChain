//
//  CryptoManager.swift
//  AccountChain
//
//  Created by Emre Öztürk on 25.12.2023.
//

import Foundation
import CommonCrypto

class CryptoManager {
    
    public static var shared: CryptoManager = CryptoManager()
    private init() {}
    
    func hashPassword(password: String, salt: Data) -> String {
        let passwordData = password.data(using: .utf8)!
        let saltedPasswordData = passwordData + salt
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = saltedPasswordData.withUnsafeBytes { saltedPasswordBuffer in
            _ = CC_SHA256(saltedPasswordBuffer.baseAddress, CC_LONG(saltedPasswordBuffer.count), &hash)
        }
        
        return Data(hash).map { String(format: "%02hhx", $0) }.joined()
    }
}
