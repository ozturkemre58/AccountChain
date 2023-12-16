//
//  AuthentcationViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import FirebaseAuth

class AuthentcationViewController: UIViewController {

    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpActionButton: UIButton!
    
    @IBOutlet weak var signInActionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    
    
    @IBAction func signUpAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailField.text ?? "", password: self.passwordField.text ?? "")  { [weak self] (result, error)  in
            
            if error != nil {   print("Ben aslında yoqum")} else {
                
                
            }
            
            
            
        }
    }
    
    
    @IBAction func signInAction(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailField.text ?? "", password: passwordField.text ?? "") { [weak self] (result, error) in
            
            if error != nil { print("EMREEEE: \(error?.localizedDescription)")} else {
                let vc = TabBarController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)

            }
            
            
        }
        
        
    }
}
