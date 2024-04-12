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
    var passwordLabel = UILabel()
    
    var dateView = UIView()
    var dateLabel = UILabel()
    
    var updateInfoButton = UIButton()
    
    
    var viewModel: CardDetailViewModel
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        
        headView.addSubview(removeCardImage)
        removeCardImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.right.equalToSuperview().offset(-10)
        }
        
        removeCardImage.backgroundColor = .clear
        
        removeCardImage.image = UIImage(named: "remove_icon")
        
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
        
        passwordField.isSecureTextEntry = true
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
    }
    
    func configView() {
        var item: CardModel = self.viewModel.card
        self.titleLabel.text = item.cardTitle
        self.emailField.text = item.cardEmail
        self.usernameField.text = item.cardUsername
        self.passwordField.text = item.cardPassword
    }
    
    @objc func showPassword() {
        if self.passwordField.isSecureTextEntry {
            self.passwordField.isSecureTextEntry = false
        } else { self.passwordField.isSecureTextEntry = true }
    }
    
    @objc func backAction() {
        //backAction
    }
}
