//
//  SignUpViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 7.01.2024.
//

import Foundation
import Firebase

class SignUpViewModel {
    
    func signUpAction(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                print("Sign Up Error: \(String(describing: error?.localizedDescription))")
                MessageManager.shared.show(message: error?.localizedDescription ?? "", type: .error)
                completion(false)
            } else {
                ConstantManager.shared.dbKey = result?.user.uid ?? ""
                completion(true)
            }
        }
    }
}
