//
//  AuthentcationViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import SnapKit

class AuthentcationViewController: UIViewController {
    
    var infoView = UIView()
    var welcomeLabel = UILabel()
    var infoLabel = UILabel()
    
    var customInputView = UIView()
    var emailLabel = UILabel()
    var emailField = UITextField()
    var passwordLabel = UILabel()
    var passwordField = UITextField()
    
    var actionView = UIView()
    var signInWithAppleButton = UIButton()
    var signInActionButton = UIButton()
    var resetPasswordLabel = UILabel()
    var registerActionLabel = UILabel()
    
    let viewModel: AuthenticationViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        prepareView()
    }
    
   
    func prepareView() {
        view.backgroundColor = .white
        
        //infoView
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.20)
        }

        infoView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoView)
            make.centerX.equalTo(infoView)
        }
        
        infoView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(infoView)
        }
       
        
        //inputView
        view.addSubview(customInputView)
        customInputView.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25)
        }
        
        customInputView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(customInputView.snp.top)
            make.left.equalTo(customInputView).offset(20)
            make.height.equalTo(customInputView).multipliedBy(0.10)
        }
        
        
        //emailField
        customInputView.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.equalTo(customInputView).offset(20)
            make.right.equalTo(customInputView).offset(-20)
            make.height.equalTo(customInputView).multipliedBy(0.25)
        }
       
        
        //passwordLabel
        customInputView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.left.equalTo(customInputView).offset(20)
            make.height.equalTo(customInputView).multipliedBy(0.10)
        }
        
        //passwordField
        customInputView.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.equalTo(customInputView).offset(20)
            make.right.equalTo(customInputView).offset(-20)
            make.height.equalTo(customInputView).multipliedBy(0.25)
        }
       
        //actionView
        view.addSubview(actionView)
        actionView.snp.makeConstraints { make in
            make.top.equalTo(customInputView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.25) 
        }
        
        //signInButton
        actionView.addSubview(signInActionButton)
        signInActionButton.snp.makeConstraints { make in
            make.top.equalTo(actionView.snp.top).offset(20)
            make.left.equalTo(customInputView).offset(20)
            make.right.equalTo(customInputView).offset(-20)
            make.height.equalTo(customInputView).multipliedBy(0.25)
        }
    
    
        //signInWithApple
        actionView.addSubview(signInWithAppleButton)
        signInWithAppleButton.snp.makeConstraints { make in
            make.top.equalTo(signInActionButton.snp.bottom).offset(15)
            make.left.equalTo(customInputView).offset(20)
            make.right.equalTo(customInputView).offset(-20)
            make.height.equalTo(customInputView).multipliedBy(0.25)
        }

        
        //register action
        view.addSubview(registerActionLabel)
        registerActionLabel.snp.makeConstraints { make in
            make.top.equalTo(actionView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    func configView() {
        
        //infoView
        welcomeLabel.text = "Sign In"
        welcomeLabel.font = UIFont.customFont(font: .helvetica, type: .bold, size: 20)
        
        //emailLabel
        emailLabel.text = "Email"
        emailLabel.font = UIFont.customFont(font: .helvetica, type: .regular, size: 16)
        
        //emailField
        emailField.placeholder = "Enter your email"
        emailField.borderStyle = .roundedRect
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        emailField.leftViewMode = .always
        emailField.keyboardType = .emailAddress
        emailField.delegate = self
        
        //passwordLabel
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.customFont(font: .helvetica, type: .regular, size: 16)
        
        //passwordField
        passwordField.placeholder = "Enter your password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.rightViewMode = .always
        let createPasswordButton = UIButton(type: .system)
        createPasswordButton.tintColor = .systemGray4
        createPasswordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        createPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        let buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonContainerView.addSubview(createPasswordButton)

        createPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createPasswordButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 8),
            createPasswordButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -8),
            createPasswordButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 8),
            createPasswordButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -8)
        ])
        passwordField.rightView = buttonContainerView
        
        //signInButton
        signInActionButton.setTitle("Sign In", for: .normal)
        signInActionButton.layer.cornerRadius = 5
        signInActionButton.backgroundColor = .systemGray
        
        //signInWithApple
        signInWithAppleButton.setImage(UIImage(named: "appleLogo"), for: .normal)
        signInWithAppleButton.setTitle("Continue with Apple", for: .normal)
        signInWithAppleButton.setTitleColor(.black, for: .normal)
        signInWithAppleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        signInWithAppleButton.backgroundColor = .white
        signInWithAppleButton.layer.cornerRadius = 5
        signInWithAppleButton.layer.borderWidth = 1
        signInWithAppleButton.layer.borderColor = UIColor.systemGray4.cgColor

        let imageInset: CGFloat = 30
        signInWithAppleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageInset, bottom: 0, right: 0)
        
        //registerLabel
        registerActionLabel.text = "Don't have an Account? Sign Up"
        registerActionLabel.textColor = .systemGray4
        let attributedString = NSMutableAttributedString(string: registerActionLabel.text!)
        let signUpRange = (registerActionLabel.text! as NSString).range(of: "Sign Up")
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: signUpRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signUpRange)
        registerActionLabel.attributedText = attributedString
        registerActionLabel.isUserInteractionEnabled = true
        let registerGesture = UITapGestureRecognizer(target: self, action: #selector(signUpGesture))
        registerActionLabel.addGestureRecognizer(registerGesture)

    }
    
    @objc func signInAction() {
        viewModel.signInAction(email: self.emailField.text ?? "", password: self.passwordField.text ?? "") { [weak self] success in
            if success {
                self?.presentTabBar()
            }
        }
    }
    
    @objc func showPassword() {
        if self.passwordField.isSecureTextEntry {
            self.passwordField.isSecureTextEntry = false
        } else { self.passwordField.isSecureTextEntry = true }
    }
    
    @objc func signUpGesture() {
        presentSignUp()
    }
    
    func presentTabBar() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func presentSignUp() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
}

extension AuthentcationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
