//
//  SignUpViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 7.01.2024.
//

import Foundation
import Firebase

class SignUpViewModel {
    
    func signUpAction(email: String?, password: String?, phone: String?, username: String?, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (result, error) in
            if error != nil {
                print("Sign Up Error: \(String(describing: error?.localizedDescription))")
                MessageManager.shared.show(message: error?.localizedDescription ?? "", type: .error)
                completion(false)
            } else {
                // Firebase Authentication işlemi başarılı, kullanıcıyı Firestore'a kaydedelim
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(result!.user.uid)
                
                var userData: [String: Any] = [:]
                
                // Kullanıcı adı ve telefon numarasını veritabanına ekleyelim
                if let username = username {
                    userData["username"] = username
                }
                if let phoneNumber = phone {
                    userData["phoneNumber"] = phoneNumber
                }
                
                userRef.setData(userData, merge: true) { error in
                    if let error = error {
                        print("Error saving user data to Firestore: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("User data saved successfully to Firestore")
                        completion(true)
                    }
                }
            }
        }
    }


 

}
