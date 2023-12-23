//
//  NewCardViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import UIKit
import Firebase

class NewCardViewController: UIViewController {
    
    @IBOutlet weak var cardTitle: UITextField!
    @IBOutlet weak var cardEmail: UITextField!
    @IBOutlet weak var cardUsername: UITextField!
    @IBOutlet weak var cardPassword: UITextField!
    
    @IBOutlet weak var createCardButton: UIButton!
    
    let viewModel: NewCardViewModel = NewCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    func configView() {
        self.createCardButton.layer.cornerRadius = 10
        
        self.cardTitle.delegate = self
        self.cardEmail.delegate = self
        self.cardUsername.delegate = self
        self.cardPassword.delegate = self
        
        self.cardTitle.layer.cornerRadius = 5
        self.cardEmail.layer.cornerRadius = 5
        self.cardUsername.layer.cornerRadius = 5
        self.cardPassword.layer.cornerRadius = 5
    }
    
    func clearTextFields() {
        self.cardTitle.clearText()
        self.cardEmail.clearText()
        self.cardUsername.clearText()
        self.cardPassword.clearText()
    }
    
    @IBAction func createCardAction(_ sender: Any) {
        
        let data = ["title": self.cardTitle.text ?? "", "email": self.cardEmail.text ?? "", "username": self.cardUsername.text ?? "", "password": self.cardPassword.text ?? ""] as [String: Any]
        
        viewModel.sendCreateCard(postParameter: data) { [weak self] success in
            if success {
                self?.clearTextFields()
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
}

extension NewCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        textField.resignFirstResponder()
            return true
        }
}
