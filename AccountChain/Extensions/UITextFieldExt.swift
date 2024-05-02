//
//  UITextFieldExt.swift
//  AccountChain
//
//  Created by Emre Ozturk on 20.12.2023.
//

import Foundation
import UIKit

extension UITextField {
    func clearText() {
        self.text = ""
    }
}

extension UIViewController {
    func addDismissButtonToKeyboard(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Create a UIImage with the desired image
        if let originalImage = UIImage(named: "keyboard_dismiss") {
            let resizedImage = originalImage.resized(to: CGSize(width: 24, height: 24))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            
            // Create a UIBarButtonItem with the UIImage
            let dismissButton = UIBarButtonItem(image: tintedImage, style: .plain, target: self, action: #selector(dismissKeyboard))
            dismissButton.tintColor = UIColor.systemBlue
            
            // Set the UIBarButtonItem to the toolbar
            toolbar.setItems([flexibleSpace, dismissButton], animated: false)
            
            // Set the toolbar as the input accessory view for the text field
            textField.inputAccessoryView = toolbar
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
