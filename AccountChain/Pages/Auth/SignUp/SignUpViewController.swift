//
//  SignUpViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 7.01.2024.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    var emailField = DefaultTextField()
    var usernameField = DefaultTextField()
    var passwordField = DefaultTextField()
    var phoneField = DefaultTextField()
    var welcomeLabel = UILabel()
    var infoLabel = UILabel()
    var phoneNumberInfo = UILabel()
    var emailInfo = UILabel()
    var usernameInfo = UILabel()
    var passwordInfo = UILabel()
    var signInLabel = UILabel()
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        configView()
    }
    
    func prepareView() {
        
        view.backgroundColor = .base
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(15)
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
        }
        
        view.addSubview(phoneNumberInfo)
        phoneNumberInfo.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(phoneField)
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberInfo.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        
        view.addSubview(emailInfo)
        emailInfo.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailInfo.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        
        view.addSubview(usernameInfo)
        usernameInfo.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(usernameField)
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(usernameInfo.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        
        view.addSubview(passwordInfo)
        passwordInfo.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordInfo.snp.bottom).offset(7.5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configView() {
        
        //welcomeLabel
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = .boldSystemFont(ofSize: 26)
        welcomeLabel.textColor = .whiteBlack
        
        //infoLabel
        infoLabel.text = "Enter Your Details To Sign Up"
        infoLabel.textColor = .whiteBlack
        
        //phoneInfoLabel
        phoneNumberInfo.text = "Phone Number"
        phoneNumberInfo.textColor = .whiteBlack
        //phoneField
        phoneField.backgroundColor = .whiteBlack
        phoneField.placeholder = "Enter Your Phone Number"
        phoneField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        phoneField.leftViewMode = .always
        phoneField.layer.cornerRadius = 5
        phoneField.keyboardType = .phonePad
        
        //emailFieldInfo
        emailInfo.text = "Email"
        emailInfo.textColor = .whiteBlack
        //emailField
        emailField.backgroundColor = .whiteBlack
        emailField.placeholder = "Enter Your Email"
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        emailField.leftViewMode = .always
        emailField.layer.cornerRadius = 5
        emailField.keyboardType = .emailAddress
        
        //usernameInfo
        usernameInfo.text = "Username"
        usernameInfo.textColor = .whiteBlack
        //usernameField
        usernameField.backgroundColor = .whiteBlack
        usernameField.placeholder = "Enter Your Username"
        usernameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        usernameField.leftViewMode = .always
        usernameField.layer.cornerRadius = 5
        
        //passwordInfo
        passwordInfo.text = "Password"
        passwordInfo.textColor = .whiteBlack
        //passwordField
        passwordField.backgroundColor = .whiteBlack
        passwordField.placeholder = "Enter Your Password"
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        passwordField.leftViewMode = .always
        passwordField.layer.cornerRadius = 5
        
        //signInLabel
        signInLabel.textColor = .whiteBlack
        signInLabel.text = "Already Have An Account? Sign In"
        let attributedString = NSMutableAttributedString(string: signInLabel.text!)
        let signInRange = (signInLabel.text! as NSString).range(of: "Sign In")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: signInRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signInRange)
        signInLabel.attributedText = attributedString
        signInLabel.isUserInteractionEnabled = true
        var dismissGesture = UITapGestureRecognizer(target: self, action: #selector(closePage))
        signInLabel.addGestureRecognizer(dismissGesture)
    }
    
    @objc func closePage() {
        self.dismiss(animated: true)
    }
    
}
