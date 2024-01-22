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
        //topView
        topView.backgroundColor = .baseBorder
       //( topView.addBorder(width: 1.0, color: UIColor(hex: "3066BE") ?? .blue)
        topView.layer.borderWidth = 1.0
        topView.layer.cornerRadius = 10
        
        contentView.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(60)
        }
        
        
        //headerView
        headerView.backgroundColor = .clear
        topView.addSubview(headerView)
        
        headerView.snp.makeConstraints { make in
            make.centerY.equalTo(topView)
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
            make.centerY.equalTo(headerView)
            make.left.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    func configure(viewModel: CardModel?) {
        self.title.text = viewModel?.cardTitle ?? ""
        self.cardId = viewModel?.cardId
    }
}
