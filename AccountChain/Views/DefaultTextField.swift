//
//  DefaultTextField.swift
//  AccountChain
//
//  Created by Emre Öztürk on 8.01.2024.
//

import UIKit

class DefaultTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureAppearance()
        applyCornerRadius()
        applyBorder()
        applyShadow()
        applyPadding()
    }

    private func configureAppearance() {
        borderStyle = .none
        backgroundColor = .white
    }

    private func applyCornerRadius() {
        layer.cornerRadius = frame.size.height / 2
    }

    private func applyBorder() {
        layer.borderWidth = 0.50
        layer.borderColor = UIColor.white.cgColor
    }

    private func applyShadow() {
        layer.shadowOpacity = 1
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.gray.cgColor
    }

    private func applyPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}

