//
//  HomeViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyGradient(withHexColors: ["#2EDB73","#FFFFFF"], startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0, y: 0))
        self.testLabel.text = "Home"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
