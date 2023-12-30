//
//  PasswordGeneratorViewController.swift
//  AccountChain
//
//  Created by Emre Öztürk on 15.12.2023.
//

import UIKit
import Firebase
import SnapKit

class PasswordGeneratorViewController: UIViewController {
    
    let topView = UIView()
    let passwordLabel = UILabel()
    let generateButton = DefaultButton()
    let copyButton = UIButton()

    let viewModel: PasswordGeneratorViewModel = PasswordGeneratorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
    }
    
    func configView() {
        //view
        view.backgroundColor = .white
        //topView
        topView.backgroundColor = .white
        topView.addBorder(width: 1.0, color: UIColor(hex: "3066BE") ?? .blue)
        topView.layer.borderWidth = 1.0
        topView.layer.cornerRadius = 15
        
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(180)
        }
        
        //copyButton
        copyButton.backgroundColor = .baseButton
        copyButton.addBorder(width: 1.0, color: .systemPink)
        copyButton.backgroundColor = .baseButton
        copyButton.layer.cornerRadius = 20
        copyButton.setImage(UIImage(named: "copy_icon"), for: .normal)
        
        topView.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(topView.safeAreaLayoutGuide).offset(45)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        copyButton.addTarget(self, action: #selector(copyToBoard), for: .touchUpInside)

        //generateButton
        generateButton.backgroundColor = .white
        generateButton.addBorder(width: 1.0, color: .baseBorder)
        generateButton.layer.cornerRadius = 15
        generateButton.setTitle("Şifre Oluştur", for: .normal)
        generateButton.setTitleColor(.baseBorder, for: .normal)
        topView.addSubview(generateButton)
        
        generateButton.snp.makeConstraints { make in
            make.top.equalTo(topView.safeAreaLayoutGuide).offset(120)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(40)
        }
        
        generateButton.addTarget(self, action: #selector(generateButtonTap), for: .touchUpInside)
        //passwordLabel
        passwordLabel.textColor = .baseButton
        topView.addSubview(passwordLabel)
        passwordLabel.text = "Test"
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.safeAreaLayoutGuide).offset(50)
            make.left.equalToSuperview().offset(75)
            make.width.equalTo(220)
        }
        
    }
    
    @objc func generateButtonTap() {
        self.passwordLabel.text = self.viewModel.generatePassword()
    }
    
    @objc func copyToBoard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.passwordLabel.text
        MessageManager.shared.show(in: self.view, message: "Şifre kopyalandı!", type: .success)
    }    
}
