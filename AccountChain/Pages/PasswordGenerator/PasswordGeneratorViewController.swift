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
       
        //self.testview.applyGradient(withHexColors: ["FFA500","#FFFFFF"], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }

    @IBAction func signOut(_ sender: Any) {
        do {
           try  Auth.auth().signOut()
        } catch {
            print("Sign Out Error")
        }
    }
}
