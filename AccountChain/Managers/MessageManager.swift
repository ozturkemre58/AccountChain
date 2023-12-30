//
//  ToastMessageManager.swift
//  AccountChain
//
//  Created by Emre Öztürk on 30.12.2023.
//

import UIKit
import SnapKit

class MessageManager: UIView {
    static let shared: MessageManager = MessageManager()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(iconImageView)
        addSubview(messageLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func show(in view: UIView, message: String, backgroundColor: UIColor) {
        messageLabel.text = message
        self.backgroundColor = backgroundColor
        
        view.addSubview(self)
        
        self.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(70)
        }
        
        layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1.0
        }) { _ in
            self.hide()
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
