//
//  UIViewExt.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(withHexColors colors: [String], startPoint: CGPoint, endPoint: CGPoint) {
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
        
    func setGradientBackground(withHexColors colors: [String], startPoint: CGPoint, endPoint: CGPoint) {
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

            layer.insertSublayer(gradientLayer, at: 0)
        }
    
    func addBorder(width: CGFloat, color: UIColor){
      self.layer.borderWidth = width
      self.layer.borderColor = color.cgColor
    }
}
