//
//  HomeViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configView()
        self.tableView.reloadData()
        self.searchView.layer.borderWidth = 1.0
        self.searchView.layer.borderColor = UIColor(named:"base_button_color")?.cgColor
    }
    
    func configView() {
        
        //searchField
        self.searchField.delegate = self
        self.searchField.enablesReturnKeyAutomatically = true
        self.searchField.leftViewMode = .always
        
        //radius
        tableView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 15
        
        //gestureRecognizer
        let searchViewGesture = UITapGestureRecognizer(target: self, action: #selector(enableSearchField))
        self.searchView.addGestureRecognizer(searchViewGesture)
        
        
        viewModel.fetchData()
        
    }
    
    @objc func enableSearchField() {
        self.searchField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
