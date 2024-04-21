//
//  ToastMessageManager.swift
//  AccountChain
//
//  Created by Emre Öztürk on 30.12.2023.
//

import UIKit
import SnapKit

enum MessageType {
    case error
    case info
    case success
}

class MessageManager: UIView {
    
    static let shared: MessageManager = MessageManager()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
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
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.equalTo(24) // İkon boyutu
        }
        
        messageLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func show(message: String, type: MessageType) {
        messageLabel.text = message
        
        switch type {
        case .error:
            setupUIForError()
        case .info:
            setupUIForInfo()
        case .success:
            setupUIForSuccess()
        }
        
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        keyWindow.addSubview(self)
        
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
    
    private func setupUIForError() {
        backgroundColor = UIColor.red.withAlphaComponent(1)
        iconImageView.image = UIImage(named: "")
    }
    
    private func setupUIForInfo() {
        backgroundColor = UIColor.orange.withAlphaComponent(1)
        iconImageView.image = UIImage(named: "")
    }
    
    private func setupUIForSuccess() {
        backgroundColor = .systemBlue
        iconImageView.image = UIImage(named: "")
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
