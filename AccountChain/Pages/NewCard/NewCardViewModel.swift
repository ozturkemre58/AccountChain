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
        fireStoreDB.collection(ConstantManager.shared.dbKey).addDocument(data: postParameter) { [weak self] (error) in
            if let error = error {
                print("FirebasePostError: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
