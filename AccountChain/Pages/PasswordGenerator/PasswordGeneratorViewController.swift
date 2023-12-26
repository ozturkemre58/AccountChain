//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase

class PasswordGeneratorViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    
    let viewModel: PasswordGeneratorViewModel = PasswordGeneratorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    func configView() {
        self.copyButton.isHidden = true
        self.passwordLabel.text = ""
        self.copyButton.layer.cornerRadius = 10
        self.generateButton.layer.cornerRadius = 10
        self.generateButton.layer.borderColor = UIColor(hex: "3066BE")?.cgColor
        self.generateButton.layer.borderWidth = 1.0
    }
    
    
    @IBAction func generateAction(_ sender: Any) {
        self.passwordLabel.text = self.viewModel.generatePassword()
        self.copyButton.isHidden = false
    }
    
    
    @IBAction func copyAction(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        
        pasteboard.string = self.passwordLabel.text
        
        let alert = UIAlertController(title: "\(pasteboard.string ?? "")", message: "Metin kopyalandı!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Log Out Error: \(error.localizedDescription)")
        }
        
    }
}
