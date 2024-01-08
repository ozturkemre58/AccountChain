//
//  AuthentcationViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import SnapKit

class AuthentcationViewController: UIViewController {
    
    var imageView = UIImageView()
    var welcomeLabel = UILabel()
    var bottomView = UIView()
    var emailField = UITextField()
    var passwordField = UITextField()
    var signUpActionButton = UIButton()
    var signInActionButton = DefaultButton()
    var seperatorView = UIView()
    var resetPasswordLabel = UILabel()
    var registerActionLabel = UILabel()
    
    let viewModel: AuthenticationViewModel = AuthenticationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        prepareView()
    }
    
   
    func prepareView() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.55)
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        bottomView.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        bottomView.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        bottomView.addSubview(signInActionButton)
        signInActionButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        bottomView.addSubview(seperatorView)
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(signInActionButton.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(2)
            
        }
        
        bottomView.addSubview(resetPasswordLabel)
        resetPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        bottomView.addSubview(registerActionLabel)
        registerActionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
        }
    }
    
    func configView() {
        //bottomView
        self.bottomView.backgroundColor = .base
        self.bottomView.layer.cornerRadius = 35
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //seperatorView
        seperatorView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        
        //imageView
        imageView.image = UIImage(named: "welcome_key_icon")
        //emailField
        emailField.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        emailField.addBorder(width: 1, color: .lightGray)
        emailField.layer.cornerRadius = 15
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        emailField.leftViewMode = .always
        emailField.placeholder = "Email"
        emailField.keyboardType = .emailAddress
        emailField.delegate = self
        
        //passwordField
        passwordField.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        passwordField.addBorder(width: 1, color: .lightGray)
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        passwordField.leftViewMode = .always
        passwordField.placeholder = "Password"
        passwordField.layer.cornerRadius = 15
        passwordField.delegate = self
        //signInButton
        signInActionButton.layer.cornerRadius = 15
        signInActionButton.setTitle("Sign In", for: .normal)
        signInActionButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        let darkTheme = traitCollection.userInterfaceStyle == .dark ? true : false
        if darkTheme {
            signInActionButton.darkTheme = true
        } else {
            signInActionButton.lightTheme = true
        }

        //labels
        resetPasswordLabel.text = "Forgot Password"
        resetPasswordLabel.textColor = .whiteBlack

        
        //registerLabel
        registerActionLabel.text = "Don't have an Account? Sign Up"
        registerActionLabel.textColor = .whiteBlack
        let attributedString = NSMutableAttributedString(string: registerActionLabel.text!)
        let signUpRange = (registerActionLabel.text! as NSString).range(of: "Sign Up")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: signUpRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signUpRange)
        registerActionLabel.attributedText = attributedString
        registerActionLabel.isUserInteractionEnabled = true
        let registerGesture = UITapGestureRecognizer(target: self, action: #selector(signUpGesture))
        registerActionLabel.addGestureRecognizer(registerGesture)

        //welcomeLabel
        welcomeLabel.text = "Log in to get started."
        welcomeLabel.font = UIFont.systemFont(ofSize: 16)
        welcomeLabel.textColor = .gray
    }
    
    @objc func signInAction() {
        viewModel.signInAction(email: self.emailField.text ?? "", password: self.passwordField.text ?? "") { [weak self] success in
            if success {
                self?.presentTabBar()
            }
        }
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
