//
//  NewCardViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import Foundation
import Firebase
import Security

class NewCardViewModel {
    
    func sendCreateCard(postParameter: [String: Any], completion: @escaping (Bool) -> Void) {
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection(ConstantManager.shared.dbKey).addDocument(data: postParameter) { (error) in
            if let error = error {
                print("FirebasePostError: \(error.localizedDescription)")
                completion(false)
            } else {
                MessageManager.shared.show(message: "Card successfully created!", type: .success)
                completion(true)
            }
        }
    }
    
 //   func savePassword(password: String, account: String, service: String) {
 //       guard let passwordData = password.data(using: .utf8) else {
 //           return
 //       }
//
 //       let account = account
 //       var query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
 //                                   kSecAttrAccount as String: account,
 //                                   kSecAttrServer as String: "www.x.com",
 //                                   kSecValueData as String: passwordData]
 //
 //       let status = SecItemAdd(query as CFDictionary, nil)
 //       guard status == errSecSuccess else {
 //           print("Failed to save password with status: \(status)")
 //           return
 //       }
 //
 //       print("Password saved successfully.")
 //   }
    
    func savePassword(password: String, account: String, service: String) {
        guard let passwordData = password.data(using: .utf8) else {
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: passwordData,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]

        let status = SecItemAdd(query.merging(attributes, uniquingKeysWith: { (_, new) in new }) as CFDictionary, nil)
        if status == errSecDuplicateItem {
            let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            if updateStatus != errSecSuccess {
                if let errorString = SecCopyErrorMessageString(updateStatus, nil) {
                    print("Error updating item: \(errorString)")
                }
            } else {
                print("Password updated successfully")
            }
        } else if status != errSecSuccess {
            if let errorString = SecCopyErrorMessageString(status, nil) {
                print("Error: \(errorString)")
            }
        } else {
            print("Password saved successfully")
        }
    }




    func generateKey() -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:'<>,.?/"
           var password = ""

           for _ in 0..<13 {
               let randomIndex = Int(arc4random_uniform(UInt32(allowedChars.count)))
               let randomChar = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomIndex)]
               password.append(randomChar)
           }

           return password
    }
}
