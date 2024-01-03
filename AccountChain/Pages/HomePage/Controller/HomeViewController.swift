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
        
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func configView() {
        
        //searchField
        self.searchField.delegate = self
        self.searchField.enablesReturnKeyAutomatically = true
        self.searchField.leftViewMode = .always
        
        //radius
        tableView.layer.cornerRadius = 10
        searchView.layer.cornerRadius = 15
        
        //border
        self.searchView.layer.borderWidth = 2.0
        self.searchView.layer.borderColor = UIColor(named:"base_button_color")?.cgColor
        
        //gestureRecognizer
        let searchViewGesture = UITapGestureRecognizer(target: self, action: #selector(enableSearchField))
        self.searchView.addGestureRecognizer(searchViewGesture)
        
        setupView()
        loadData()
    }
    
    @objc func enableSearchField() {
        self.searchField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func showDeleteMenu(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Sil", message: "Bu öğeyi silmek istediğinizden emin misiniz?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Sil", style: .destructive) { action in
             self.viewModel.deleteItemAtIndexPath(indexPath) { success in
                 if success { 
                     self.loadData()
                 }
            }
        }
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func searchHandler(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            self.viewModel.cardData = self.viewModel.cardSearchData.filter { $0.cardTitle?.lowercased().contains(searchText.lowercased()) ?? false }
        } else {
            self.viewModel.cardData = self.viewModel.cardSearchData
        }
        self.tableView.reloadData()
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let touchPoint = gesture.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                showDeleteMenu(at: indexPath)
            }
        }
    }

}
