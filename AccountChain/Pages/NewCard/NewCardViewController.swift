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
    var cartTitleLabel = UILabel()
    var cartEmailLabel = UILabel()
    var cartUsernameLabel = UILabel()
    var cartPasswordLabel = UILabel()
    
    var cardTitle = UITextField()
    var cardEmail = UITextField()
    var cardUsername = UITextField()
    var cardPassword =  UITextField()
    var createCardButton = UIButton()
    
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
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        pageTitleView.addSubview(pageTitleLabel)
        pageTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        //cartTitleLabel
        view.addSubview(cartTitleLabel)
        cartTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageTitleView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        //cardTitle
        view.addSubview(cardTitle)
        cardTitle.snp.makeConstraints { make in
            make.top.equalTo(cartTitleLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        //emailLabel
        view.addSubview(cartEmailLabel)
        cartEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(cardTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        //cardEmail
        view.addSubview(cardEmail)
        cardEmail.snp.makeConstraints { make in
            make.top.equalTo(cartEmailLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //cartUsernameLabel
        view.addSubview(cartUsernameLabel)
        cartUsernameLabel.snp.makeConstraints { make in
            make.top.equalTo(cardEmail.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        //cardUsername
        view.addSubview(cardUsername)
        cardUsername.snp.makeConstraints { make in
            make.top.equalTo(cartUsernameLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //cartPasswordLabel
        view.addSubview(cartPasswordLabel)
        cartPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(cardUsername.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        //cardPassword
        view.addSubview(cardPassword)
        cardPassword.snp.makeConstraints { make in
            make.top.equalTo(cartPasswordLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(50)
        }
        
        //createCardButton
        view.addSubview(createCardButton)
        createCardButton.snp.makeConstraints { make in
            make.top.equalTo(cardPassword.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
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

    }
    
    func configView() {
        //cartTitleLabel
        self.cartTitleLabel.text = "Platform Name"
        
        //cardCreateButton
        self.createCardButton.layer.cornerRadius = 10
        self.createCardButton.setTitle("Create", for: .normal)
        self.createCardButton.setTitleColor(.white, for: .normal)
        self.createCardButton.backgroundColor = .systemBlue
        self.createCardButton.addTarget(self, action: #selector(createCardAction), for: .touchUpInside)
        self.createCardButton.isEnabled = false
        
        //cardTitle
        self.cardTitle.delegate = self
        self.cardTitle.layer.cornerRadius = 5
        self.cardTitle.addBorder(width: 1, color: .systemGray4)
        cardTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardTitle.leftViewMode = .always
        cardTitle.placeholder = "Instagram"
        
        //cartEmailLabel
        self.cartEmailLabel.text = "Email"
        
        //cardEmail
        self.cardEmail.delegate = self
        self.cardEmail.layer.cornerRadius = 5
        self.cardEmail.addBorder(width: 1, color: .systemGray4)
        cardEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardEmail.leftViewMode = .always
        cardEmail.placeholder = "Forexample@gmail.com"
        cardEmail.keyboardType = .emailAddress
        
        //cartUsernameLabel
        self.cartUsernameLabel.text = "Username"
        
        //cardUsername
        self.cardUsername.delegate = self
        self.cardUsername.layer.cornerRadius = 5
        self.cardUsername.addBorder(width: 1, color: .systemGray4)
        cardUsername.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardUsername.leftViewMode = .always
        cardUsername.placeholder = "JhonDoe"
        
        //cartpassword
        self.cartPasswordLabel.text = "Password"
        
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
        
    }
    
    func clearTextFields() {
        self.cardTitle.clearText()
        self.cardEmail.clearText()
        self.cardUsername.clearText()
        self.cardPassword.clearText()
    }
    
    func isTextFieldValid() -> Bool {
        return !(self.cardTitle.text?.isEmpty ?? true) &&
        !(self.cardEmail.text?.isEmpty ?? true) &&
        !(self.cardUsername.text?.isEmpty ?? true) &&
        !(self.cardPassword.text?.isEmpty ?? true)
    }
    
    func currentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func createPasswordButtonTapped() {
        self.cardPassword.text = viewModel.generateKey()
    }
    
    @objc func showPassword() {
        if self.cardPassword.isSecureTextEntry {
            self.cardPassword.isSecureTextEntry = false
        } else { self.cardPassword.isSecureTextEntry = true }
    }
    
    @objc func createCardAction() {
        guard self.isTextFieldValid() else {
            MessageManager.shared.show(message: "Boş alanları doldurunuz!", type: .info)
            return
        }
        
        
        let key = viewModel.generateKey()
        KeychainManager.shared.saveDataToKeychain(data: self.cardPassword.text ?? "", forKey: key)
        let data = ["title": self.cardTitle.text ?? "", "email": self.cardEmail.text ?? "", "username": self.cardUsername.text ?? "", "password": key,  "date": self.currentDate()] as [String: Any]
        
        viewModel.sendCreateCard(postParameter: data) { [weak self] success in
            if success {
                self?.clearTextFields()
                self?.tabBarController?.selectedIndex = 0
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
        if textField == self.cardTitle || textField == self.cardEmail || textField == self.cardUsername || textField == self.cardPassword {
            self.createCardButton.isEnabled =  self.isTextFieldValid()
        }
        return true
    }
}
