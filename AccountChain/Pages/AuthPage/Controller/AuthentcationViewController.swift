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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // configView()
    }
    
   
    
    
    @IBAction func signUpAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.emailField.text ?? "", password: self.passwordField.text ?? "")  { [weak self] (result, error)  in
            
            if error != nil {   print("Ben aslında yoqum")} else {
                
                
            }
            
            
            
        }
    }
}
