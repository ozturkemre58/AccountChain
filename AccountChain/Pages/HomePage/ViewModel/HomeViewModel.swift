//
//  HomeViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import Foundation
import Firebase

class HomeViewModel {
    
    var data: [CardModel] = []
    var cellDataSource: Observable<[CardModel]> = Observable(nil)

    func numberOfSections() -> Int {
            1
        }
        
    func numberOfRows(in section: Int) -> Int {
        self.data.count
    }
    
    
    
    func fetchData() -> [CardModel] {
        let firebaseDB = Firestore.firestore()
        
        firebaseDB.collection(ConstantManager.shared.dbKey).addSnapshotListener { (documentSnapshot, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let documents = documentSnapshot?.documents else {
                print("Document data was empty.")
                return
            }
            
            for document in documents {
                
                let data = document.data()
                
                let title = data["title"] as? String
                let email = data["email"] as? String
                let username = data["username"] as? String
                let password = data["password"] as? String
                
                let model = CardModel(cardTitle: title ?? "", cardEmail: email ?? "", cardUsername: username ?? "", cardPassword: password ?? "")
                self.data.append(model)
            }
        }
        return self.data
    }
}



