//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase
import SnapKit

class PasswordGeneratorViewController: UIViewController {
    
    let topView = UIView()
    let passwordLabel = UILabel()
    let generateButton = DefaultButton()
    let copyButton = UIButton()

    let viewModel: PasswordGeneratorViewModel = PasswordGeneratorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func generateButtonTap() {
        signOut()
        self.passwordLabel.text = self.viewModel.generatePassword()
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            // Kullanıcı başarıyla çıkış yaptı, burada gerekli ek işlemleri yapabilirsiniz
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    @objc func copyToBoard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.passwordLabel.text
        MessageManager.shared.show(message: "Şifre kopyalandı!", type: .success)
    }
}
