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
    var rightImageView = UIImageView()
    var headerView = UIView()
    var iconView = UIImageView()
    var title = UILabel()
    var email = UILabel()
    
    var cardId: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
        self.topView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configView() {
        
        contentView.backgroundColor = .clear
        
        topView.addBorder(width: 1, color: .systemGray3)
        topView.layer.cornerRadius = 5
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(60)
        }

        
        topView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).offset(10)
            make.bottom.equalTo(topView.snp.bottom).offset(-10)
            make.left.equalTo(topView.snp.left).offset(10)
  
        }
        iconView.contentMode = .scaleAspectFit
        
        topView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).offset(20)
            make.bottom.equalTo(topView.snp.bottom).offset(-20)
            make.right.equalTo(topView.snp.right).offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.image = UIImage(named: "right_arrow")
        //headerView
        topView.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.top).offset(10)
            make.bottom.equalTo(topView.snp.bottom).offset(-10)
            make.left.equalTo(iconView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            
        }
        
        //titleLabel
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 18)

        title.text = "Title"
        headerView.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.top)
            make.left.equalToSuperview()
            make.height.equalTo(18)
        }
        
        //emailLabel
        email.textColor = .systemGray3
        email.font = UIFont.customFont(font: .helvetica, type: .regular, size: 12)
        
        headerView.addSubview(email)
        email.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.height.equalTo(12)
        }
        

    }
    
    func configure(viewModel: CardModel?) {
        self.title.text = viewModel?.cardTitle ?? ""
        self.email.text = viewModel?.cardEmail ?? ""
        self.cardId = viewModel?.cardId
        var iconName = viewModel?.iconName ?? "linkedin_icon"
        self.iconView.image =  UIImage(named: "\(iconName)")
    }
}

