//
//  CryptoManager.swift
//  AccountChain
//
//  Created by Emre Öztürk on 25.12.2023.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    public static var shared: KeychainManager = KeychainManager()
    private init() {}
    
    func saveDataToKeychain(data: String, forKey key: String) {
        let keychain = KeychainSwift()
        keychain.set(data, forKey: key)
    }

    func fetchDataFromKeychain(forKey key: String) -> String? {
        let keychain = KeychainSwift()
        return keychain.get(key)
    }
}
