//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class PasswordGeneratorViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    @IBOutlet weak var testview: DefaultButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient(withHexColors: ["#2EDB73","#FFFFFF"], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        self.testLabel.text  = "Password Generator"
       
        //self.testview.applyGradient(withHexColors: ["FFA500","#FFFFFF"], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }

}
