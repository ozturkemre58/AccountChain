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
        
        registerCell()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.cardData[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}
