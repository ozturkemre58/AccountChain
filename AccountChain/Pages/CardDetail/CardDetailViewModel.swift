//
//  CardDetailViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 23.01.2024.
//

import UIKit
import Firebase

class CardDetailViewModel {
    var card: CardModel
    
    init(card: CardModel) {
        self.card = card
    }

    func updateKeychainData(data: String) {
        KeychainManager.shared.updateDataInKeychain(data: data, forKey: self.card.keychainKey ?? "")
    }
    
    func sendUpdateCard(cartId: String, updatedData: [String: Any], completion: @escaping (Bool) -> Void) {
        let fireStoreDB = Firestore.firestore()
        let documentReference = fireStoreDB.collection(ConstantManager.shared.dbKey).document(cartId)
        
        documentReference.updateData(updatedData) { error in
            if let error = error {
                print("FirebaseUpdateError: \(error.localizedDescription)")
                completion(false)
            } else {
                MessageManager.shared.show(message: "Bilgileriniz Güncellendi.", type: .success)
                completion(true)
            }
        }
    }

    func removeCard(completion: @escaping (_ success: Bool) -> Void) {
        let firebaseDB = Firestore.firestore()
        let documentReference = firebaseDB.collection(ConstantManager.shared.dbKey).document(self.card.cardId ?? "")
        KeychainManager.shared.removeDataInKeychain(forKey: self.card.cardPassword ?? "")
        documentReference.delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
                MessageManager.shared.show(message: "\(error.localizedDescription)", type: .error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

