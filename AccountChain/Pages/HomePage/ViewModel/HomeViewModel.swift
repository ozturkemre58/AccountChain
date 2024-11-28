//
//  HomeViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import Foundation
import Firebase

protocol HomeViewModelDelegate: AnyObject {
    func searchWithVoice(searchText: String)
}

class HomeViewModel {
    
    var cardData: [CardModel] = []
    var cardSearchData: [CardModel] = []
    var cellDataSource: Observable<[CardModel]> = Observable(nil)
    weak var delegate: HomeViewModelDelegate?
    
    private lazy var speechRecognizer: ESpeechRecognizer = {
        let recognizer = ESpeechRecognizer()
        return recognizer
    }()
    
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.cardData.count
    }
    
    
    
    func fetchData(completion: @escaping (Result<[CardModel], Error>) -> Void) {
        self.cardData.removeAll()
        self.cardSearchData.removeAll()

        let firebaseDB = Firestore.firestore()
        let collectionKey = ConstantManager.shared.dbKey

        firebaseDB.collection(collectionKey).getDocuments { snapshot, error in

            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("No documents found in collection: \(collectionKey)")
                completion(.success([])) // Boş sonuç döndür
                return
            }

            let models: [CardModel] = documents.compactMap { document in
                let data = document.data()
                let id = document.documentID
                let title = data["title"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let passwordKey = data["password"] as? String ?? ""
                let selectedIcon = data["icon"] as? String ?? ""

                return CardModel(
                    cardId: id,
                    cardTitle: title,
                    cardEmail: email,
                    cardUsername: username,
                    cardPassword: self.fetchPassword(key: passwordKey),
                    keychainKey: passwordKey,
                    selectedIcon: selectedIcon
                )
            }

            self.cardData = models
            self.cardSearchData = models
            completion(.success(models))
        }
    }

    
    func removeCard(documentID: String, completion: @escaping (_ success: Bool) -> Void) {
        let firebaseDB = Firestore.firestore()
        let documentReference = firebaseDB.collection(ConstantManager.shared.dbKey).document(documentID)
        
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
    
    func deleteItemAtIndexPath(_ indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        let documentIDToDelete = self.cardData[indexPath.row].cardId ?? ""
        KeychainManager.shared.removeDataInKeychain(forKey: self.cardData[indexPath.row].cardPassword ?? "")
        self.removeCard(documentID: documentIDToDelete) { success in
            if success {
                completion(true)
            } else {
                MessageManager.shared.show(message: "Kart Silinemedi", type: .error)
                completion(false)
            }
        }
    }
    
    func fetchPassword(key: String?) -> String {
        return KeychainManager.shared.fetchDataFromKeychain(forKey: key ?? "") ?? ""
    }
    
    func startVoiceSearch() {
        self.speechRecognizer.requestAuthorization(completion: { [weak self] authorized in
            if !authorized {
                return
            }
            
            self?.speechRecognizer.startSpeechToText(completion: { [weak self] text in
                if let text = text, !text.isEmpty {
                    self?.delegate?.searchWithVoice(searchText: text)
                }
                
                self?.speechRecognizer.stopSpeechToText()

            })
        })
    }
}



