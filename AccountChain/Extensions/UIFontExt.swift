//
//  UIFont.swift
//  AccountChain
//
//  Created by emre ozturk on 27.03.2024.
//

import Foundation
import UIKit


enum CustomFontType {
    case medium
    case regular
    case bold
}

enum CustomFont {
    case helvetica

    var name: String {
        switch self {
            case .helvetica: return "Helvetica"
        }
    }
}

extension UIFont {
    static func customFont(font: CustomFont, type: CustomFontType, size: CGFloat) -> UIFont {
        var weight: UIFont.Weight
        switch type {
        case .regular:
            weight = .regular
        case .bold:
            weight = .bold
        case .medium:
            weight = .medium
        }

        return UIFont(name: font.name, size: size)?.withWeight(weight) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }

    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits([.traitBold])
        return UIFont(descriptor: descriptor!, size: pointSize)
    }
}


//let boldFont = UIFont(font: .helvetica, type: .bold, size: 20)
