//
//  PasswordGeneratorViewModel.swift
//  AccountChain
//
//  Created by Emre Öztürk on 22.12.2023.
//

import Foundation

class PasswordGeneratorViewModel {
    
    func generatePassword() -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:'<>,.?/"
           var password = ""

           for _ in 0..<13 {
               let randomIndex = Int(arc4random_uniform(UInt32(allowedChars.count)))
               let randomChar = allowedChars[allowedChars.index(allowedChars.startIndex, offsetBy: randomIndex)]
               password.append(randomChar)
           }

           return password
    }
}
