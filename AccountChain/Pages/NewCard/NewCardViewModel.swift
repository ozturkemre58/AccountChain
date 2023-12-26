//
//  NewCardViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import Foundation
import Firebase

class NewCardViewModel {
    
    func sendCreateCard(postParameter: [String: Any], completion: @escaping (Bool) -> Void) {
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection(ConstantManager.shared.dbKey).addDocument(data: postParameter) { (error) in
            if let error = error {
                print("FirebasePostError: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
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
