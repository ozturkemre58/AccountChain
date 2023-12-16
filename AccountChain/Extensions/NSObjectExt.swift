//
//  NSObjectExt.swift
//  AccountChain
//
//  Created by Emre Öztürk on 16.12.2023.
//

import Foundation
import UIKit

extension NSObject {
  static var nameAsString: String {
    return String(describing: self)
  }
}


protocol ReusableView {
  static var reuseIdentifier: String { get }
}

// MARK: HReusableView Extension

extension ReusableView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

// MARK: UITableViewCell Extension

extension UITableViewCell: ReusableView {}

extension UITableViewHeaderFooterView: ReusableView {}
