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
    
    
    let viewModel: NewCardViewModel = NewCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func createCardAction(_ sender: Any) {
        
        let data = ["title": self.cardTitle.text ?? "", "email": self.cardEmail.text ?? "", "username": self.cardUsername.text ?? "", "password": self.cardPassword.text ?? ""] as [String: Any]
        
        viewModel.sendCreateCard(postParameter: data) { [weak self] success in
            if success {
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
}
