//
//  CardCell.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//
import UIKit
import SnapKit

class CardCell: UITableViewCell {
    
    var topView = UIView()
    var headerView = UIView()
    var detailView = UIView()
    var emailView = UIView()
    var usernameView = UIView()
    var passwordView = UIView()
    
    var title = UILabel()
    var email = UILabel()
    var username = UILabel()
    var password = UILabel()
    
    var emailCopyButton = UIButton()
    var usernameCopyButton = UIButton()
    var passwordCopyButton = UIButton()
    var showPasswordButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
        self.topView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configView() {
        //topView
        topView.backgroundColor = .baseBorder
        topView.addBorder(width: 1.0, color: UIColor(hex: "3066BE") ?? .blue)
        topView.layer.borderWidth = 1.0
        topView.layer.cornerRadius = 10
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(160)
        }
        
        
        //headerView
        headerView.backgroundColor = .clear
        topView.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(topView.safeAreaLayoutGuide).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
        }
        
        //titleLabel
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 20)

        title.text = "Title"
        headerView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalTo(headerView.safeAreaLayoutGuide).offset(3)
            make.left.equalToSuperview()
            make.height.equalTo(24)
        }
        
        //detailView
        detailView.backgroundColor = .baseBorder
        topView.addSubview(detailView)
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(2)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(120)
        }
        
        //emailView
        emailView.backgroundColor = .clear
        detailView.addSubview(emailView)
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        //emailLabel
        email.textColor = .white
        emailView.addSubview(email)
        
        email.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.top).offset(3)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(24)
        }
        
        //emailCopyButton
        emailCopyButton.setImage(UIImage(named: "copy_icon"), for: .normal)
        emailCopyButton.addBorder(width: 1.0, color: .white)
        emailCopyButton.backgroundColor = .baseButton
        emailCopyButton.layer.cornerRadius = 18
        emailView.addSubview(emailCopyButton)
        
        emailCopyButton.snp.makeConstraints { make in
            make.top.centerX
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }

        
        //usernameView
        usernameView.backgroundColor = .clear
        detailView.addSubview(usernameView)
        
        usernameView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        //usernameLabel
        username.textColor = .white
        usernameView.addSubview(username)
        
        username.snp.makeConstraints { make in
            make.top.centerX
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(24)
        }
        
        //usernameCopyButton
        usernameCopyButton.setImage(UIImage(named: "copy_icon"), for: .normal)
        usernameCopyButton.addBorder(width: 1.0, color: .white)
        usernameCopyButton.backgroundColor = .baseButton
        usernameCopyButton.layer.cornerRadius = 18
        usernameView.addSubview(usernameCopyButton)
        
        usernameCopyButton.snp.makeConstraints { make in
            make.top.centerX
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        //passwordView
        passwordView.backgroundColor = .clear
        detailView.addSubview(passwordView)
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(usernameView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        //passwordLabel
        password.textColor = .white
        passwordView.addSubview(password)
        
        password.snp.makeConstraints { make in
            make.top.centerX
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(24)
        }
        
        //passwordCopyButton
        passwordCopyButton.setImage(UIImage(named: "copy_icon"), for: .normal)
        passwordCopyButton.addBorder(width: 1.0, color: .white)
        passwordCopyButton.backgroundColor = .baseButton
        passwordCopyButton.layer.cornerRadius = 18
        passwordView.addSubview(passwordCopyButton)
        
        passwordCopyButton.snp.makeConstraints { make in
            make.top.centerX
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
    }
    
    func configure(viewModel: CardModel?) {
         self.title.text = viewModel?.cardTitle ?? ""
         self.email.text = viewModel?.cardEmail ?? ""
         self.username.text = viewModel?.cardUsername ?? ""
         self.password.text = viewModel?.cardPassword ?? ""
    }
}
