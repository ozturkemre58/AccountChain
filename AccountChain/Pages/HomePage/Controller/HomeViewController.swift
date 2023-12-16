//
//  HomeViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchViewField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
    }
    
    func configView() {

        tableView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 15
    }
}
