//
//  DefaultButton.swift
//  AccountChain
//
//  Created by Emre Öztürk on 29.12.2023.
//

import Foundation
import UIKit

class DefaultButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1 : 0.7
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        
        self.backgroundColor = .baseButton
        self.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchCancel), for: .touchCancel)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDragExit), for: .touchDragExit)
        
        
    }
    
    
    private func configureTouchUpInside() {
        self.backgroundColor = .baseButton
        self.setTitleColor(.white, for: .normal)
    }
    
    private func configureTouchDownButtonStyle() {
        self.backgroundColor = .white
        self.setTitleColor(.baseButton, for: .normal)
    }
    
    
    @objc func touchDown() {
        configureTouchDownButtonStyle()
    }
    
    @objc func touchCancel() {
        configureTouchDownButtonStyle()
    }
    
    @objc func touchUpInside() {
        configureTouchUpInside()
    }
    
    @objc func touchDragExit() {
        configureTouchUpInside()
    }
}
