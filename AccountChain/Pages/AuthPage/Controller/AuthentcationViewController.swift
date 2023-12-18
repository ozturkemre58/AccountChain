//
//  AuthentcationViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class AuthentcationViewController: UIViewController {

    let viewModel: AuthenticationViewModel = AuthenticationViewModel()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpActionButton: UIButton!
    
    @IBOutlet weak var signInActionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    
    
    @IBAction func signUpAction(_ sender: Any) {
        viewModel.signUpAction(email: self.emailField.text ??  "", password: self.passwordField.text ?? "") { [weak self] success in
            if success {
                self?.presentTabBar()
            }
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        viewModel.signInAction(email: self.emailField.text ?? "", password: self.passwordField.text ?? "") { [weak self] success in
            if success {
                self?.presentTabBar()
            }
        }
    }
    
    func presentTabBar() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
