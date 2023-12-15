//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class PasswordGeneratorViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testLabel.text  = "Password Generator"
    }

}
