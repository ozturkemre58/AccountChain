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
    
    var backButton = DefaultButton()
    var titleLabel = UILabel()
    var removeCardButton = DefaultButton()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.gray : UIColor.red
        
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
        
        backButton.backgroundColor = .red
        backButton.layer.cornerRadius = 7.5
        
        headView.addSubview(removeCardButton)
        removeCardButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(headView.snp.height).multipliedBy(0.50)
            make.height.equalTo(headView.snp.height).multipliedBy(0.50)
            make.right.equalToSuperview().offset(-10)
        }
        
        removeCardButton.backgroundColor = .red
        removeCardButton.layer.cornerRadius = 7.5
        
        headView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backButton.snp.right).offset(10)
            make.right.equalTo(removeCardButton.snp.left).offset(-10)
        }
        
        titleLabel.text = "Hepsiburada"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        topView.addSubview(bodyView)
        bodyView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        bodyView.addSubview(detailTopView)
        detailTopView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        detailTopView.backgroundColor = .lightGray
        detailTopView.layer.cornerRadius = 10
        
        //emailView
        detailTopView.addSubview(emailView)
        emailView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.175)
        }
        
        emailView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5)
            make.left.equalToSuperview().offset(15)
        }
        emailLabel.text = "email"
        
        emailView.addSubview(emailField)
        emailField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        emailField.text = "emailimdemailim@gmail.com"
        emailField.font = .boldSystemFont(ofSize: 20)
        
        emailView.addBorder(width: 1, color: .orange)
        emailView.layer.cornerRadius = 10
        
        //date
        detailTopView.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(backButton.snp.height)
        }
    
        dateView.layer.cornerRadius = 10
        dateView.backgroundColor = .red
        
        dateView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-3)
            make.centerX.equalToSuperview()
        }
        
        dateView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top).offset(-3)
            make.centerX.equalToSuperview()
        }
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.text = "Change Date"
        descriptionLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.text = "11.10.2024"
    }
}