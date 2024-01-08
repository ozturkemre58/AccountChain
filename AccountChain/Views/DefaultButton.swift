//
//  DefaultButton.swift
//  AccountChain
//
//  Created by Emre Öztürk on 29.12.2023.
//

import Foundation
import UIKit

class DefaultButton: UIButton {
    
    private var isLightTheme = false {
        didSet {
            self.configureTouchUpInside()
        }
    }
    
    private var isDarkTheme = false {
        didSet {
            self.configureTouchUpInside()
        }
    }
    
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
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
          if self.isLightTheme {
              self.backgroundColor = .whiteBlack
              self.setTitleColor(.base, for: .normal)
          } else if self.isDarkTheme {
              self.backgroundColor = .black
              self.setTitleColor(.white, for: .normal)
          } else {
              self.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
            self.setTitleColor(.blue, for: .normal)
          }
        }
    }
    
    private func configureTouchDownButtonStyle() {
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.6)
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

extension DefaultButton {

    var lightTheme: Bool {
    set {
      self.isLightTheme = newValue
    }
    
    get {
      return self.isLightTheme
    }
  }
  
  var darkTheme: Bool {
    set {
      self.isDarkTheme = newValue
    }
    
    get {
      return self.isDarkTheme
    }
  }
}
