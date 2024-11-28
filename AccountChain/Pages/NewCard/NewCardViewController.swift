//
//  NewCardViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import UIKit
import Firebase
import SnapKit
import SwiftUI

class NewCardViewController: UIViewController {
    
    var pageTitleView = UIView()
    var pageTitleLabel = UILabel()
    var cardTitleLabel = UILabel()
    var cardEmailLabel = UILabel()
    var cardUsernameLabel = UILabel()
    var cardPasswordLabel = UILabel()
    
    var cardTitle = UITextField()
    var cardEmail = UITextField()
    var cardUsername = UITextField()
    var cardPassword =  UITextField()
    var createCardButton = UIButton()
    var iconField = UITextField()
    let iconImageView = UIImageView()
    var selectedIcon = "card"
    let viewModel: NewCardViewModel = NewCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func prepareView() {
        view.backgroundColor = .white
        view.addSubview(pageTitleView)
        pageTitleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.10)
        }
        
        pageTitleView.addSubview(pageTitleLabel)
        pageTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        //IconButton
        view.addSubview(iconField)
        iconField.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        //cardTitleLabel
        view.addSubview(cardTitleLabel)
        cardTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        //cardTitle
        view.addSubview(cardTitle)
        cardTitle.snp.makeConstraints { make in
            make.top.equalTo(cardTitleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        //emailLabel
        view.addSubview(cardEmailLabel)
        cardEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(cardTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        //cardEmail
        view.addSubview(cardEmail)
        cardEmail.snp.makeConstraints { make in
            make.top.equalTo(cardEmailLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //cardUsernameLabel
        view.addSubview(cardUsernameLabel)
        cardUsernameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardEmail.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        //cardUsername
        view.addSubview(cardUsername)
        cardUsername.snp.makeConstraints { make in
            make.top.equalTo(cardUsernameLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //cardPasswordLabel
        view.addSubview(cardPasswordLabel)
        cardPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(cardUsername.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        //cardPassword
        view.addSubview(cardPassword)
        cardPassword.snp.makeConstraints { make in
            make.top.equalTo(cardPasswordLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //createCardButton
        view.addSubview(createCardButton)
        createCardButton.snp.makeConstraints { make in
            make.top.equalTo(cardPassword.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        // Create the 'show password' button
        // Create the 'show password' button
        let showPasswordButton = UIButton(type: .system)
        showPasswordButton.tintColor = .systemBlue
        showPasswordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)

        let createPasswordButton = UIButton(type: .system)
        createPasswordButton.tintColor = .systemBlue
        createPasswordButton.setImage(UIImage(named: "plus-circle"), for: .normal)
        createPasswordButton.addTarget(self, action: #selector(createPasswordButtonTapped), for: .touchUpInside)

        // Create a container view for both buttons
        let buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40)) // Width set to 80
        buttonContainerView.addSubview(createPasswordButton)
        buttonContainerView.addSubview(showPasswordButton)

        // Set autoresizing mask to make sure buttons resize properly
        buttonContainerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Position the 'show password' button
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showPasswordButton.leadingAnchor.constraint(equalTo: createPasswordButton.trailingAnchor, constant: 8),
            showPasswordButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -8),
            showPasswordButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 8),
            showPasswordButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -8),
            showPasswordButton.widthAnchor.constraint(equalToConstant: 40) // Width set to 40
        ])

        createPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createPasswordButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 8),
            createPasswordButton.trailingAnchor.constraint(equalTo: showPasswordButton.leadingAnchor, constant: -8), // Adjusted the constraint
            createPasswordButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 8),
            createPasswordButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -8)
        ])

        cardPassword.rightView = buttonContainerView
        cardPassword.rightViewMode = .always
        
        
        //iconField
        iconImageView.tintColor = .systemGray4
        iconImageView.image = UIImage(named: "card")

        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageViewContainerView.addSubview(iconImageView)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: imageViewContainerView.leadingAnchor, constant: 8),
            iconImageView.trailingAnchor.constraint(equalTo: imageViewContainerView.trailingAnchor, constant: -8),
            iconImageView.topAnchor.constraint(equalTo: imageViewContainerView.topAnchor, constant: 8),
            iconImageView.bottomAnchor.constraint(equalTo: imageViewContainerView.bottomAnchor, constant: -8)
        ])
        iconField.leftView = imageViewContainerView

        let switchIconButton = UIButton(type: .system)
        switchIconButton.tintColor = .systemGray2
        switchIconButton.setImage(UIImage(named: "chevron_down"), for: .normal)
        switchIconButton.addTarget(self, action: #selector(openIconPage), for: .touchUpInside)

        let buttonIconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonIconContainerView.addSubview(switchIconButton)

        switchIconButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchIconButton.leadingAnchor.constraint(equalTo: buttonIconContainerView.leadingAnchor, constant: 8),
            switchIconButton.trailingAnchor.constraint(equalTo: buttonIconContainerView.trailingAnchor, constant: -8),
            switchIconButton.topAnchor.constraint(equalTo: buttonIconContainerView.topAnchor, constant: 8),
            switchIconButton.bottomAnchor.constraint(equalTo: buttonIconContainerView.bottomAnchor, constant: -8)
        ])
        iconField.rightView = buttonIconContainerView
        iconImageView.contentMode = .scaleAspectFit
        iconField.rightViewMode = .always
        iconField.leftViewMode = .always
        iconField.placeholder = "Select card icon"

    }
    
    func configView() {
        //cardTitleLabel
        self.cardTitleLabel.text = "Platform Name"
        
        //cardCreateButton
        self.createCardButton.layer.cornerRadius = 10
        self.createCardButton.setTitle("Create", for: .normal)
        self.createCardButton.setTitleColor(.white, for: .normal)
        self.createCardButton.backgroundColor = .systemBlue
        self.createCardButton.addTarget(self, action: #selector(createCardAction), for: .touchUpInside)
        self.createCardButton.isEnabled = true
        
        //cardTitle
        self.cardTitle.delegate = self
        self.cardTitle.layer.cornerRadius = 5
        self.cardTitle.addBorder(width: 1, color: .systemGray4)
        cardTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardTitle.leftViewMode = .always
        cardTitle.placeholder = "Instagram"
        
        //cardEmailLabel
        self.cardEmailLabel.text = "Email"
        
        //cardEmail
        self.cardEmail.delegate = self
        self.cardEmail.layer.cornerRadius = 5
        self.cardEmail.addBorder(width: 1, color: .systemGray4)
        cardEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardEmail.leftViewMode = .always
        cardEmail.placeholder = "Forexample@gmail.com"
        cardEmail.keyboardType = .emailAddress
        
        //cardUsernameLabel
        self.cardUsernameLabel.text = "Username"
        
        //cardUsername
        self.cardUsername.delegate = self
        self.cardUsername.layer.cornerRadius = 5
        self.cardUsername.addBorder(width: 1, color: .systemGray4)
        cardUsername.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardUsername.leftViewMode = .always
        cardUsername.placeholder = "JhonDoe"
        
        //cardpassword
        self.cardPasswordLabel.text = "Password"
        
        //cardPassword
        self.cardPassword.delegate = self
        self.cardPassword.layer.cornerRadius = 5
        self.cardPassword.addBorder(width: 1, color: .systemGray4)
        cardPassword.leftView = UIView(frame: CGRect(x: 0 , y: 0, width: 10, height: 40))
        cardPassword.leftViewMode = .always
        cardPassword.placeholder = "************"
        cardPassword.isSecureTextEntry = true
        cardPassword.textContentType = .password
        cardPassword.textContentType = .oneTimeCode
        
        
        //IconButton
        iconField.addBorder(width: 1, color: .systemGray4)
        iconField.layer.cornerRadius = 5
        let iconFieldTapGesture = UITapGestureRecognizer(target: self, action: #selector(openIconPage))
        iconField.addGestureRecognizer(iconFieldTapGesture)
        iconField.isUserInteractionEnabled = true
        
        if !isConsentGiven() {
            showDataSharingAlert()
        }

    }
    
    func clearTextFields() {
        self.cardTitle.clearText()
        self.cardEmail.clearText()
        self.cardUsername.clearText()
        self.cardPassword.clearText()
    }
    
    func isTextFieldValid() -> Bool {
        return !(self.cardTitle.text?.isEmpty ?? true) &&
        !(self.cardUsername.text?.isEmpty ?? true)
    }
    
    func currentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    private func showDataSharingAlert() {
            let alertController = UIAlertController(
                title: "Data Sharing Notice",
                message: "The card information you are about to add will be securely transmitted to our servers to complete the process. Please confirm that you consent to this action before proceeding.",
                preferredStyle: .alert
            )

            let agreeAction = UIAlertAction(title: "I Agree", style: .default) { _ in
                // Save user's consent in UserDefaults
                UserDefaults.standard.set(true, forKey: "isCardDataSharingConsentGiven")
                UserDefaults.standard.synchronize()
                
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            }

            alertController.addAction(agreeAction)
            alertController.addAction(cancelAction)

            present(alertController, animated: true, completion: nil)
        }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openIconPage() {
        let vc = IconListViewController { iconModel in
            if let data = iconModel {
                self.cardTitle.text = data.iconName
                self.iconField.text = data.iconName
                self.iconImageView.image = UIImage(named: data.image)
                self.selectedIcon = data.image
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    @objc func createPasswordButtonTapped() {
        self.cardPassword.text = viewModel.generateKey()
    }
    
    @objc func showPassword() {
        if self.cardPassword.isSecureTextEntry {
            self.cardPassword.isSecureTextEntry = false
        } else { self.cardPassword.isSecureTextEntry = true }
    }
    
    func isConsentGiven() -> Bool {
        return UserDefaults.standard.bool(forKey: "isCardDataSharingConsentGiven")
    }
    
    @objc func createCardAction() {
        guard self.isTextFieldValid() else {
            MessageManager.shared.show(message: "Please fill in all required fields.", type: .info)
            return
        }
        
        guard let emailText = self.cardEmail.text, emailText.contains("@"), emailText.contains(".") else {
            MessageManager.shared.show(message: "Invalid Email", type: .info)
            return
        }
        
        guard let passwordText = self.cardPassword.text, passwordText.count >= 8 else {
            MessageManager.shared.show(message: "Your password is too short. Please choose a password that is at least 8 characters long.", type: .info)
            return
        }
        
        let key = viewModel.generateKey()
        KeychainManager.shared.saveDataToKeychain(data: self.cardPassword.text ?? "", forKey: key)
      //  viewModel.savePassword(password: self.cardPassword.text ?? "", account: self.cardEmail.text ?? "", service: "")
        
        let data = ["title": self.cardTitle.text ?? "", "email": self.cardEmail.text ?? "", "username": self.cardUsername.text ?? "", "password": key,  "date": self.currentDate(), "icon": self.selectedIcon] as [String: Any]
        
        viewModel.sendCreateCard(postParameter: data) { [weak self] success in
            if success {
                //self?.clearTextFields()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension NewCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}


//MARK: createPassword button logic 

