//
//  AuthenticationViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 18.12.2023.
//

import Foundation
import Firebase

class AuthenticationViewModel {
    
    weak var authVC: AuthentcationViewController?
    
    
    func signUpAction(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                print("Sign Up Error: \(String(describing: error?.localizedDescription))")
                completion(false)
            } else {
                ConstantManager.shared.dbKey = result?.user.uid ?? ""
                completion(true)
            }
        }
    }
    
    func signInAction(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                print("Sign In Error: \(String(describing: error?.localizedDescription))")
                completion(false)
            } else {
                ConstantManager.shared.dbKey = result?.user.uid ?? ""
                completion(true)
            }
        }
    }
}
