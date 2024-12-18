//
//  UIButtonExt.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//

import Foundation
import UIKit

extension UIButton {
    func applyButtonGradient(withHexColors colors: [String], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        var cgColors: [CGColor] = []
        
        for hexColor in colors {
            if let uiColor = UIColor(hex: hexColor) {
                cgColors.append(uiColor.cgColor)
            }
        }
        
        gradientLayer.colors = cgColors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.addSublayer(gradientLayer)
    }
    
}
