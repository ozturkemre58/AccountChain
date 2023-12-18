//
//  HomeViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: HomeViewModel = HomeViewModel()
    var cardData: [CardModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configView()
    }
    
    func configView() {
        
        //searchField
        self.searchField.delegate = self
        self.searchField.enablesReturnKeyAutomatically = true
        self.searchField.leftViewMode = .always
        
        //radius
        tableView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 15
        
        //gestureRecognizer
        let searchViewGesture = UITapGestureRecognizer(target: self, action: #selector(enableSearchField))
        self.searchView.addGestureRecognizer(searchViewGesture)
        
        
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
            
            self.cardData.removeAll()
            
            for document in documents {
                
                let data = document.data()
                
                let title = data["title"] as? String
                let email = data["email"] as? String
                let username = data["username"] as? String
                let password = data["password"] as? String
                
                let model = CardModel(cardTitle: title ?? "", cardEmail: email ?? "", cardUsername: username ?? "", cardPassword: password ?? "")
                self.cardData.append(model)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func enableSearchField() {
        self.searchField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
