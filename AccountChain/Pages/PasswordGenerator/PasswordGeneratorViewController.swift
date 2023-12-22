//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase

class PasswordGeneratorViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }

    @IBAction func signOut(_ sender: Any) {
        do {
           try  Auth.auth().signOut()
        } catch {
            print("Sign Out Error")
        }
    }
}
