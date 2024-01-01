//
//  NewCardViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 17.12.2023.
//

import UIKit
import Firebase
import SnapKit

class NewCardViewController: UIViewController {
    
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
    
    func prepareView() {
        view.backgroundColor = .white
        //cardTitle
        view.addSubview(cardTitle)
        cardTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        //cardEmail
        view.addSubview(cardEmail)
        cardEmail.snp.makeConstraints { make in
            make.top.equalTo(cardTitle.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        //cardUsername
        view.addSubview(cardUsername)
        cardUsername.snp.makeConstraints { make in
            make.top.equalTo(cardEmail.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        //cardPassword
        view.addSubview(cardPassword)
        cardPassword.snp.makeConstraints { make in
            make.top.equalTo(cardUsername.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
    }
    
    func configView() {
        self.createCardButton.layer.cornerRadius = 10
        
        self.cardTitle.delegate = self
        self.cardEmail.delegate = self
        self.cardUsername.delegate = self
        self.cardPassword.delegate = self
        
        self.cardTitle.layer.cornerRadius = 5
        self.cardEmail.layer.cornerRadius = 5
        self.cardUsername.layer.cornerRadius = 5
        self.cardPassword.layer.cornerRadius = 5
        
        self.cardTitle.addBorder(width: 1, color: .baseBorder)
        self.cardEmail.addBorder(width: 1, color: .baseBorder)
        self.cardUsername.addBorder(width: 1, color: .baseBorder)
        self.cardPassword.addBorder(width: 1, color: .baseBorder)
    }
    
    func clearTextFields() {
        self.cardTitle.clearText()
        self.cardEmail.clearText()
        self.cardUsername.clearText()
        self.cardPassword.clearText()
    }
    
    @IBAction func createCardAction(_ sender: Any) {
        
        
        let key = viewModel.generateKey()
        KeychainManager.shared.saveDataToKeychain(data: self.cardPassword.text ?? "", forKey: key)
        
        let data = ["title": self.cardTitle.text ?? "", "email": self.cardEmail.text ?? "", "username": self.cardUsername.text ?? "", "password": key] as [String: Any]
        
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
}
