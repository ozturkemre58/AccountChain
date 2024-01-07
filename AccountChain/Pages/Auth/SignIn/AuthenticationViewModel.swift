//
//  AuthenticationViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 18.12.2023.
//

import Foundation
import Firebase

class AuthenticationViewModel {
    
    func signInAction(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                print("Sign In Error: \(String(describing: error?.localizedDescription))")
                MessageManager.shared.show(message: error?.localizedDescription ?? "", type: .error)
                completion(false)
            } else {
                ConstantManager.shared.dbKey = result?.user.uid ?? ""
                completion(true)
            }
        }
    }
}
