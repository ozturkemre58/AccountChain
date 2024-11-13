//
//  SignUpViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 7.01.2024.
//

import UIKit
import SnapKit
import SwiftUI
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class SignUpViewController: UIViewController {
    
    var emailField = UITextField()
    var usernameField = UITextField()
    var passwordField = UITextField()
    var phoneField = UITextField()
    var welcomeLabel = UILabel()
    var infoLabel = UILabel()
    var phoneNumberInfo = UILabel()
    var emailInfo = UILabel()
    var usernameInfo = UILabel()
    var passwordInfo = UILabel()
    var signInLabel = UILabel()
    var createAccountButton = UIButton()
    var signInWithAppleButton = ASAuthorizationAppleIDButton()
    
    let viewModel: SignUpViewModel = SignUpViewModel()
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        configView()
    }
    
    func prepareView() {
        
        view.backgroundColor = .white
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
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
        
        view.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        
        view.addSubview(signInWithAppleButton)
        signInWithAppleButton.snp.makeConstraints { make in
            make.top.equalTo(createAccountButton.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.075)
        }
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func configView() {
        
        //welcomeLabel
        welcomeLabel.text = "Sign Up"
        welcomeLabel.font = .boldSystemFont(ofSize: 26)
        welcomeLabel.textColor = .systemBlue
        
        //infoLabel
        infoLabel.text = "Enter Your Details To Sign Up"
        infoLabel.textColor = .gray
        
        //phoneInfoLabel
        phoneNumberInfo.text = "Phone Number"
        //phoneField
        phoneField.backgroundColor = .white
        phoneField.placeholder = "Enter Your Phone Number"
        phoneField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        phoneField.leftViewMode = .always
        phoneField.layer.cornerRadius = 5
        phoneField.keyboardType = .phonePad
        phoneField.borderStyle = .roundedRect
        phoneField.delegate = self
        
        //emailFieldInfo
        emailInfo.text = "Email"
        
        //emailField
        emailField.placeholder = "Enter Your Email"
       
        // emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        emailField.leftViewMode = .always
        emailField.layer.cornerRadius = 5
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        emailField.keyboardType = .emailAddress
        emailField.borderStyle = .roundedRect
        emailField.delegate = self
        
        //usernameInfo
        usernameInfo.text = "Username"

        //usernameField
        usernameField.backgroundColor = .white
        usernameField.placeholder = "Enter Your Username"
        usernameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        usernameField.leftViewMode = .always
        usernameField.borderStyle = .roundedRect
        usernameField.layer.cornerRadius = 5
        usernameField.delegate = self
        
        //passwordInfo
        passwordInfo.text = "Password"
        //passwordField
        passwordField.backgroundColor = .white
        passwordField.placeholder = "Enter Your Password"
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        passwordField.leftViewMode = .always
        passwordField.layer.cornerRadius = 5
        passwordField.borderStyle = .roundedRect
        passwordField.delegate = self
        
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
        
        
        //createAccountButton
        createAccountButton.setTitle("Sign Up", for: .normal)
        createAccountButton.layer.cornerRadius = 5
        createAccountButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        createAccountButton.backgroundColor = .systemBlue
        
        //signInLabel
        signInLabel.textColor = .gray
        signInLabel.text = "Already Have An Account? Sign In"
        let attributedString = NSMutableAttributedString(string: signInLabel.text!)
        let signInRange = (signInLabel.text! as NSString).range(of: "Sign In")
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: signInRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: signInRange)
        signInLabel.attributedText = attributedString
        signInLabel.isUserInteractionEnabled = true
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(closePage))
        signInLabel.addGestureRecognizer(dismissGesture)
        
        //signInWithApple
        signInWithAppleButton.addTarget(self, action: #selector(appleSignIn), for: .touchUpInside)
    }
    
    @objc func closePage() {
        self.dismiss(animated: true)
    }
    
    @objc func signUpAction() {
        viewModel.signUpAction(email: self.emailField.text ??  "", password: self.passwordField.text ?? "", phone: self.phoneField.text ?? "", username: self.usernameField.text ?? "") { [weak self] success in
            if success {
                self?.presentHome()
            }
        }
    }
    

    @objc func showPassword() {
        if self.passwordField.isSecureTextEntry {
            self.passwordField.isSecureTextEntry = false
        } else { self.passwordField.isSecureTextEntry = true }
    }
    
    @objc func appleSignIn() {
        let nonce = randomNonceString()
        self.currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonceData = sha256(nonce.data(using: .utf8)!)
        let nonceString = dataToHexString(nonceData)
        request.nonce = nonceString
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ inputData: Data) -> Data {
        let hashedData = SHA256.hash(data: inputData)
        return Data(hashedData)
    }
    
    private func dataToHexString(_ data: Data) -> String {
        return data.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func presentHome() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == self.phoneField {
            let allowedCharacters = CharacterSet.decimalDigits
           let characterSet = CharacterSet(charactersIn: string)
           
           return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
}

extension SignUpViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let token = appleIDCredential.identityToken
            let nonce = self.currentNonce
            
            guard let idTokenData = token,
                  let idTokenString = String(data: idTokenData, encoding: .utf8),
                  let rawNonceData = nonce else {
                return
            }
            let firebaseAuthCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                  idToken: idTokenString,
                                                                  rawNonce: rawNonceData)
            
            
            
            Auth.auth().signIn(with: firebaseAuthCredential) { (result, error) in
                if let error = error {
                    MessageManager.shared.show(message: error.localizedDescription, type: .error)
                } else {
                    ConstantManager.shared.dbKey = result?.user.uid ?? ""
                    self.presentHome()
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        MessageManager.shared.show(message: error.localizedDescription, type: .error)
    }
}

extension SignUpViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
