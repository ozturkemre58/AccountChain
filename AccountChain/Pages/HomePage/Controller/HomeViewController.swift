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
    let myAccountButton = UIButton()
    let searchView = UIView()
    let searchField = UITextField()
    let tableView = UITableView()
    let createCardButton = UIButton()
    let microphonIndicator = UIActivityIndicatorView()
    let microphoneButton = UIButton(type: .system)
    let createCardButtonForEmpty = UIButton()

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
        
        
        let hasConsented = UserDefaults.standard.bool(forKey: "UserHasConsented")
        if !hasConsented {
            showConsentAlert()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel.cardData.removeAll()
        self.viewModel.cardSearchData.removeAll()
        self.tableView.reloadData()
    }
    
    func showConsentAlert() {
            let alert = UIAlertController(
                title: "Privacy Policy",
                message: "We collect and store your data. To continue, please accept our Privacy Policy.",
                preferredStyle: .alert
            )
            
            let privacyPolicyAction = UIAlertAction(title: "Privacy Policy", style: .default) { _ in
                if let url = URL(string: "https://www.freeprivacypolicy.com/live/e45b1415-fa4d-499f-96a9-e2b278476584") {
                    UIApplication.shared.open(url, options: [:]) {_ in
                        self.showConsentAlert()
                    }
                }
            }
            
            let acceptAction = UIAlertAction(title: "Accept", style: .default) { _ in
                UserDefaults.standard.set(true, forKey: "UserHasConsented")
            }
            
            let declineAction = UIAlertAction(title: "Decline", style: .destructive) { _ in
                self.showExitConfirmationAlert()
            }
            
            alert.addAction(privacyPolicyAction)
            alert.addAction(acceptAction)
            alert.addAction(declineAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        func showExitConfirmationAlert() {
            let exitAlert = UIAlertController(
                title: "Are you sure?",
                message: "If you decline, the application will close.",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.showConsentAlert()
            }
            
            let exitAction = UIAlertAction(title: "Close App", style: .destructive) { _ in
                exit(0)
            }
            
            exitAlert.addAction(cancelAction)
            exitAlert.addAction(exitAction)
            
            self.present(exitAlert, animated: true, completion: nil)
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

        headerView.addSubview(myAccountButton)
        myAccountButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel)
            make.right.equalToSuperview().offset(-16)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(myAccountButton.snp.height) 
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
        
        view.addSubview(createCardButtonForEmpty)
        createCardButtonForEmpty.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        // MARK: createCardButtonForEmpty
        createCardButtonForEmpty.setTitle("Create Card", for: .normal)
        createCardButtonForEmpty.setTitleColor(.white, for: .normal)
        createCardButtonForEmpty.backgroundColor = .systemBlue
        createCardButtonForEmpty.layer.cornerRadius = 10
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(createCardButton)
        createCardButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-40)
            make.width.equalTo(68)
            make.height.equalTo(68)
        }
        createCardButton.isHidden = true
    }
    
    func configView() {
        //headerLabel
        headerLabel.text = "My Cards"
        headerLabel.textColor = .systemBlue
        headerLabel.font = UIFont.customFont(font: .helvetica, type: .bold, size: 20)
        
        //accountButton
        myAccountButton.setImage(UIImage(named: "nav_user")?.withTintColor(.systemGray), for: .normal)
        
        //searchField
        addDismissButtonToKeyboard(textField: searchField)
        self.searchField.delegate = self
        self.searchField.enablesReturnKeyAutomatically = true
        self.searchField.leftViewMode = .always
        self.searchField.rightViewMode = .always
        searchField.placeholder = "Search Card"
        
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
        
        //CreateCardButton
        createCardButton.layer.cornerRadius = 34
        createCardButton.backgroundColor = .systemBlue
        createCardButton.setImage(UIImage(named: "plus-circle"), for: .normal)
        
        
        if let originalImage = UIImage(named: "plus-circle") {
            let newSize = CGSize(width: 44, height: 44)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            originalImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let resizedImage = resizedImage {
                let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
                createCardButton.setImage(tintedImage, for: .normal)
                createCardButton.tintColor = UIColor.white
            }
        }
        createCardButton.addTarget(self, action: #selector(createCardAction), for: .touchUpInside)
        createCardButtonForEmpty.addTarget(self, action: #selector(createCardAction), for: .touchUpInside)
        createCardButton.clipsToBounds = true
        
        myAccountButton.isUserInteractionEnabled = true
        myAccountButton.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        viewModel.delegate = self
        setupView()
    }
    
    func updateUIVisibilityBasedOnCardData() {
        if self.viewModel.cardData.isEmpty {
            self.tableView.isHidden = true
            self.createCardButtonForEmpty.isHidden = false
            self.createCardButton.isHidden = true
        } else {
            self.createCardButton.isHidden = false
            self.tableView.isHidden = false
            self.createCardButtonForEmpty.isHidden = true
        }
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
    
    @objc func createCardAction() {
        let createCardVC = NewCardViewController()
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(createCardVC, animated: true)
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
    
    @objc func accountButtonTapped() {
        let vc = ProfileViewController()
        self.present(vc, animated: true)
    }
}
