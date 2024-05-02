//
//  HomeViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase
import SwiftUI

class HomeViewController: UIViewController, HomeViewModelDelegate {
    let headerView = UIView()
    let headerLabel = UILabel()
    let searchView = UIView()
    let searchField = UITextField()
    let tableView = UITableView()
    let createCartButton = UIButton()
    let microphonIndicator = UIActivityIndicatorView()
    let microphoneButton = UIButton(type: .system)

    
    let viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        configView()
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func prepareView() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(headerView.snp.bottom).offset(-15)
            make.left.equalTo(headerView.snp.left).offset(20)
        }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview().offset(23)
            make.right.equalToSuperview().offset(-23)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        searchView.backgroundColor = UIColor(hex: "EAEAEA")
        searchView.layer.cornerRadius = 5
        
        searchView.addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.top)
            make.left.equalTo(searchView.snp.left)
            make.right.equalTo(searchView.snp.right)
            make.bottom.equalTo(searchView.snp.bottom)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(createCartButton)
        createCartButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(68)
            make.height.equalTo(68)
        }
    }
    
    func configView() {
        //headerLabel
        headerLabel.text = "My Carts"
        headerLabel.textColor = .systemBlue
        headerLabel.font = UIFont.customFont(font: .helvetica, type: .bold, size: 20)
        
        
        //searchField
        addDismissButtonToKeyboard(textField: searchField)
        self.searchField.delegate = self
        self.searchField.enablesReturnKeyAutomatically = true
        self.searchField.leftViewMode = .always
        self.searchField.rightViewMode = .always
        searchField.placeholder = "Search Cart"
        
        //searchfieldLeftView
        let searchImageView = UIImageView()
        searchImageView.tintColor = .systemGray4
        searchImageView.image = UIImage(named: "search_gray_icon")
        
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageViewContainerView.addSubview(searchImageView)
        
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchImageView.leadingAnchor.constraint(equalTo: imageViewContainerView.leadingAnchor, constant: 4),
            searchImageView.trailingAnchor.constraint(equalTo: imageViewContainerView.trailingAnchor, constant: -4),
            searchImageView.topAnchor.constraint(equalTo: imageViewContainerView.topAnchor, constant: 4),
            searchImageView.bottomAnchor.constraint(equalTo: imageViewContainerView.bottomAnchor, constant: -4)
        ])
        searchField.leftView = imageViewContainerView
        
        //searchFieldRightView
        microphoneButton.tintColor = .systemGray2
        microphoneButton.setImage(UIImage(named: "microphone_icon"), for: .normal)

        let buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonContainerView.addSubview(microphoneButton)
        microphoneButton.addSubview(microphonIndicator)
        microphonIndicator.hidesWhenStopped = true
        

        microphoneButton.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
        microphoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            microphoneButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 8),
            microphoneButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -8),
            microphoneButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 8),
            microphoneButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -8)
        ])
        searchField.rightView = buttonContainerView

        
        //gestureRecognizer
        let searchViewGesture = UITapGestureRecognizer(target: self, action: #selector(enableSearchField))
        self.searchView.addGestureRecognizer(searchViewGesture)
        
        //tableView
        tableView.layer.cornerRadius = 5
        
        //CreateCartButton
        createCartButton.layer.cornerRadius = 34
        createCartButton.backgroundColor = .systemBlue
        createCartButton.setImage(UIImage(named: "plus-circle"), for: .normal)
        
        
        if let originalImage = UIImage(named: "plus-circle") {
            let newSize = CGSize(width: 44, height: 44)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let resizedImage = resizedImage {
                let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
                createCartButton.setImage(tintedImage, for: .normal)
                createCartButton.tintColor = UIColor.white
            }
        }
        createCartButton.addTarget(self, action: #selector(createCartAction), for: .touchUpInside)
        createCartButton.clipsToBounds = true
        
        
        viewModel.delegate = self
        setupView()
    }
    
    func searchWithVoice(searchText: String) {
        DispatchQueue.main.async {
            self.microphoneButton.isEnabled = true
            self.microphonIndicator.stopAnimating()
            self.searchField.text = searchText
            _ = self.textField(self.searchField, shouldChangeCharactersIn: NSRange(location: 0, length: self.searchField.text?.count ?? 0), replacementString: searchText)
        }
    }
    
    @objc func enableSearchField() {
        self.searchField.becomeFirstResponder()
    }
    
    @objc func startSearch() {
        self.microphoneButton.isEnabled = false
        self.microphonIndicator.startAnimating()
        self.viewModel.startVoiceSearch()
    }
    
    func showDeleteMenu(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Are you sure you want to delete this item?", message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.viewModel.deleteItemAtIndexPath(indexPath) { success in
                if success {
                    self.loadData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
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
    
    @objc func createCartAction() {
        let createCartVC = NewCardViewController()
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(createCartVC, animated: true)
        }
    }
    
    func openDetail(card: CardModel) {
        let cardDetailViewModel = CardDetailViewModel(card: card)
        let cardDetailVC = CardDetailViewController(viewModel: cardDetailViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(cardDetailVC, animated: true)
        }
        
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        if textField == searchField {
            if searchText.isEmpty {
                viewModel.cardData = viewModel.cardSearchData
            } else {
                viewModel.cardData = viewModel.cardSearchData.filter { $0.cardTitle?.lowercased().contains(searchText.lowercased()) ?? false }
            }
            tableView.reloadData()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
