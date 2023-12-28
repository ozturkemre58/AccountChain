//
//  HomeViewController+TableView.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
    }
    
    func loadData() {
        viewModel.cardData.removeAll()
        
        viewModel.fetchData {
            self.tableView.reloadData()
        }
    }
    
    func registerCell() {
        let cardCell = UINib(nibName: CardCell.nameAsString, bundle: nil)
        self.tableView.register(cardCell, forCellReuseIdentifier: CardCell.reuseIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardCell(style: .default, reuseIdentifier: CardCell.reuseIdentifier)

        let item = viewModel.cardData[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = CardCell(style: .default, reuseIdentifier: CardCell.reuseIdentifier)
        tableView.reloadData()
    }
}
