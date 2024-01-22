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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
        
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
                
       /* headView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(headView.snp.height).multipliedBy(0.50)
            make.height.equalTo(headView.snp.height).multipliedBy(0.50)
            make.left.equalToSuperview().offset(10)
        }
        
        backButton.backgroundColor = .base
        backButton.layer.cornerRadius = 7.5
        */
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
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(removeCardImage.snp.left).offset(-10)
        }
        
        titleLabel.text = "Hepsiburada"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .base
        
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
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        detailTopView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .base : .lightGray
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
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        emailField.font = .boldSystemFont(ofSize: 20)
        emailView.addBorder(width: 1, color: .orange)
        emailView.layer.cornerRadius = 10
        
        //username
        detailTopView.addSubview(usernameView)
        usernameView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.175)
        }
        
        usernameView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5)
            make.left.equalToSuperview().offset(15)
        }
        usernameLabel.text = "email"
        
        usernameView.addSubview(usernameField)
        usernameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        usernameField.font = .boldSystemFont(ofSize: 20)
        usernameView.addBorder(width: 1, color: .orange)
        usernameView.layer.cornerRadius = 10
        
        //Password
        detailTopView.addSubview(passwordView)
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(usernameView.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.175)
        }
        
        passwordView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7.5)
            make.left.equalToSuperview().offset(15)
        }
        passwordLabel.text = "password"
        
        passwordView.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        passwordField.font = .boldSystemFont(ofSize: 20)
        passwordView.addBorder(width: 1, color: .orange)
        passwordView.layer.cornerRadius = 10
        
        detailTopView.addSubview(updateInfoButton)
        updateInfoButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.175)
        }
        
        updateInfoButton.backgroundColor = .orange
        updateInfoButton.setTitle("Update", for: .normal)
        updateInfoButton.layer.cornerRadius = 10
        
        //date
        detailTopView.addSubview(dateView)
        dateView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    
        dateView.layer.cornerRadius = 10
        dateView.backgroundColor = .clear
        dateView.addBorder(width: 1, color: .lightGray)
        
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
