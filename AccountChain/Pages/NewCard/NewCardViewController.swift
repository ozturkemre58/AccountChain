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
    var createCardButton = DefaultButton()
    
    let viewModel: NewCardViewModel = NewCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        configView()
    }
    
    func prepareView() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
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
        
        //createCardButton
        view.addSubview(createCardButton)
        createCardButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cardPassword.snp.bottom).offset(35)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    func configView() {
        //cardCreateButton
        self.createCardButton.layer.cornerRadius = 10
        self.createCardButton.setTitle("Oluştur", for: .normal)
        self.createCardButton.setTitleColor(.white, for: .normal)
        self.createCardButton.addBorder(width: 1, color: .baseBorder)
        self.createCardButton.addTarget(self, action: #selector(createCardAction), for: .touchUpInside)
        self.createCardButton.isEnabled = false
        
        //cardTitle
        self.cardTitle.delegate = self
        self.cardTitle.layer.cornerRadius = 5
        self.cardTitle.addBorder(width: 1, color: .baseBorder)
        cardTitle.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardTitle.leftViewMode = .always
        cardTitle.placeholder = "Başlık"
        
        //cardEmail
        self.cardEmail.delegate = self
        self.cardEmail.layer.cornerRadius = 5
        self.cardEmail.addBorder(width: 1, color: .baseBorder)
        cardEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardEmail.leftViewMode = .always
        cardEmail.placeholder = "Email"
        cardEmail.keyboardType = .emailAddress
        
        //cardUsername
        self.cardUsername.delegate = self
        self.cardUsername.layer.cornerRadius = 5
        self.cardUsername.addBorder(width: 1, color: .baseBorder)
        cardUsername.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        cardUsername.leftViewMode = .always
        cardUsername.placeholder = "Kullanıcı Adı"
        
        //cardPassword
        self.cardPassword.delegate = self
        self.cardPassword.layer.cornerRadius = 5
        self.cardPassword.addBorder(width: 1, color: .baseBorder)
        cardPassword.leftView = UIView(frame: CGRect(x: 0 , y: 0, width: 10, height: 40))
        cardPassword.leftViewMode = .always
        cardPassword.placeholder = "Şifre"
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
