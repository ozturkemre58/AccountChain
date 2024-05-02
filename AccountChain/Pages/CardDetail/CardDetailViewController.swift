//
//  CardDetailViewController.swift
//  AccountChain
//
//  Created by Emre Ozturk on 17.01.2024.
//

import UIKit
import SnapKit

class CardDetailViewController: UIViewController {
    
    var topView = UIView()
    
    var headView = UIView()
    var removeCartLabel = UILabel()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var removeCardImage = UIImageView()
    
    var bodyView = UIView()
   
    var descriptionLabel = UILabel()
    var detailTopView = UIView()
    
    var emailView = UIView()
    var emailField = UITextField()
    var emailLabel = UILabel()
    
    var usernameView = UIView()
    var usernameField = UITextField()
    var usernameLabel = UILabel()
    
    var passwordView = UIView()
    var passwordField = UITextField()
    var confirmPasswordField = UITextField()
    var passwordLabel = UILabel()
    var updateInfoButton = UIButton()
    
    
    var viewModel: CardDetailViewModel
    var cartId: String = ""
    var cartPassword: String?

    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        prepareView()
        configView()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func prepareView() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        topView.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }
                
       headView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(headView.snp.height).multipliedBy(0.50)
            make.height.equalTo(headView.snp.height).multipliedBy(0.50)
            make.left.equalToSuperview().offset(10)
        }
        
        backButton.layer.cornerRadius = 7.5
        backButton.setImage(UIImage(named: "left_arrow"), for: .normal)
        backButton.isHidden = true
        
        headView.addSubview(removeCartLabel)
        removeCartLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        removeCartLabel.textColor = .red
        removeCartLabel.text = "Delete"
        removeCartLabel.font = UIFont.customFont(font: .helvetica, type: .medium, size: 14)
        removeCartLabel.isUserInteractionEnabled = true
        
        headView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .systemBlue
        
        topView.addSubview(bodyView)
        bodyView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        bodyView.addSubview(detailTopView)
        detailTopView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        detailTopView.layer.cornerRadius = 10

        detailTopView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        usernameLabel.text = "User Name"
        usernameLabel.font = UIFont.customFont(font: .helvetica, type: .regular, size: 16)
        usernameLabel.textColor = UIColor(hex: "545454")
        
        detailTopView.addSubview(usernameField)
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        usernameField.borderStyle = .roundedRect
        usernameField.leftViewMode = .always
        addDismissButtonToKeyboard(textField: usernameField)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: usernameField.frame.height))
        usernameField.leftView = paddingView

        detailTopView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        emailLabel.text = "Email"
        emailLabel.font = UIFont.customFont(font: .helvetica, type: .regular, size: 16)
        emailLabel.textColor = UIColor(hex: "545454")
        
        detailTopView.addSubview(emailField)
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
       
        emailField.borderStyle = .roundedRect
        emailField.leftViewMode = .always
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: emailField.frame.height))
        emailField.leftView = emailPaddingView
        addDismissButtonToKeyboard(textField: emailField)
        
        detailTopView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.customFont(font: .helvetica, type: .regular, size: 16)
        passwordLabel.textColor = UIColor(hex: "545454")
        
        detailTopView.addSubview(passwordField)
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
       
        passwordField.isSecureTextEntry = true
        passwordField.borderStyle = .roundedRect
        passwordField.leftViewMode = .always
        passwordField.rightViewMode = .always
        let passwordFieldPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: passwordField.frame.height))
        emailField.leftView = passwordFieldPaddingView
        addDismissButtonToKeyboard(textField: passwordField)
        
        passwordField.rightViewMode = .always
        let showPasswordButton = UIButton(type: .system)
        showPasswordButton.tintColor = .systemGray4
        showPasswordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        showPasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        let buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonContainerView.addSubview(showPasswordButton)

        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showPasswordButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 8),
            showPasswordButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -8),
            showPasswordButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor, constant: 8),
            showPasswordButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor, constant: -8)
        ])
        passwordField.rightView = buttonContainerView
        
        detailTopView.addSubview(confirmPasswordField)
        confirmPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }

        confirmPasswordField.borderStyle = .roundedRect
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.delegate = self
        confirmPasswordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        confirmPasswordField.text = ""
        confirmPasswordField.isEnabled = true
        confirmPasswordField.isUserInteractionEnabled = true
        addDismissButtonToKeyboard(textField: confirmPasswordField)

        detailTopView.addSubview(updateInfoButton)
        updateInfoButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordField.snp.bottom).offset(25)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        updateInfoButton.layer.cornerRadius = 5
        updateInfoButton.backgroundColor = .systemBlue
        updateInfoButton.setTitle("Update", for: .normal)
        updateInfoButton.addTarget(self, action: #selector(updateCart), for: .touchUpInside)
    }
    
    func configView() {
        updateInfoButton.isEnabled = false
        updateInfoButton.backgroundColor = .systemGray4
        emailField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        usernameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let item: CardModel = self.viewModel.card
        self.titleLabel.text = item.cardTitle
        self.emailField.text = item.cardEmail
        self.usernameField.text = item.cardUsername
        self.passwordField.text = item.cardPassword
        self.cartId = item.cardId ?? ""
    }
    
    func currentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    @objc func showPassword() {
        if self.passwordField.isSecureTextEntry {
            self.passwordField.isSecureTextEntry = false
        } else { self.passwordField.isSecureTextEntry = true }
    }
    
    @objc func updateCart() {
        let emailText = emailField.text ?? ""
        let usernameText = usernameField.text ?? ""
        let passwordText = passwordField.text ?? ""
        let confirmPasswordText = confirmPasswordField.text ?? ""
        
        guard !emailText.isEmpty, !usernameText.isEmpty, !passwordText.isEmpty, !confirmPasswordText.isEmpty else {
            
            return
        }
        
        guard passwordText == confirmPasswordText else {
            return
        }
        let data = ["email": emailText, "username": usernameText, "date": currentDate()]
        viewModel.updateKeychainData(data: self.cartPassword ?? "")
        viewModel.sendUpdateCard(cartId: self.cartId, updatedData: data) { [weak self] success in
            if success {
                print("Update successful")
            } else {
                print("Update failed")
            }
        }
    }
    
    func addGestures() {
        let removeGesture = UITapGestureRecognizer(target: self, action: #selector(removeCart))
        self.removeCartLabel.addGestureRecognizer(removeGesture)
    }
    
    func dismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func removeCart() {
        self.viewModel.removeCard() { success in
            if success {
                self.dismissAction()
            }
        }
    }
    
    @objc func backAction() {
        dismissAction()
    }
    
}

extension CardDetailViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == confirmPasswordField {
            cartPassword = textField.text
        }
        
        let textFields: [UITextField] = [emailField, usernameField, passwordField, confirmPasswordField]
        
        let isAnyEmpty = textFields.contains { $0.text?.isEmpty ?? true }
        if isAnyEmpty {
            updateInfoButton.isEnabled = false
            updateInfoButton.backgroundColor = .systemGray4
            return
        }
        
        if passwordField.text != confirmPasswordField.text {
            updateInfoButton.isEnabled = false
            updateInfoButton.backgroundColor = .systemGray4
            return
        }
        
        updateInfoButton.isEnabled = true
        updateInfoButton.backgroundColor = .systemBlue
    }


}
