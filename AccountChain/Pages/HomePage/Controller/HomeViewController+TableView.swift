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
    
    func registerCell() {
        let cardCell = UINib(nibName: CardCell.nameAsString, bundle: nil)
        self.tableView.register(cardCell, forCellReuseIdentifier: CardCell.reuseIdentifier) 
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        let item = cardData[indexPath.row]
        cell.configure(viewModel: item)
        return cell
    }
}
