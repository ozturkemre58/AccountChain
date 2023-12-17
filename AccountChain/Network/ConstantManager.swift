//
//  ConstantManager.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import Foundation

class ConstantManager {
    
    public static var shared: ConstantManager = ConstantManager()
    
    private init() {}
    
    public var dbKey: String = ""
    
}


