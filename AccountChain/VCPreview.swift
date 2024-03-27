//
//  VCPreview.swift
//  AccountChain
//
//  Created by emre ozturk on 27.03.2024.
//

import Foundation
import SwiftUI

struct VCPreview<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T
    
    init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    func makeUIViewController(context: Context) -> T {
        viewController
    }
    
    func updateUIViewController(_ uıViewController: T, context: Context) {
        
    }
}
