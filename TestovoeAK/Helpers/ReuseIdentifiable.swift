//
//  ReuseIdentifiable.swift
//  TestovoeAK
//
//  Created by MacBook Air on 13.03.2024.
//

import UIKit

protocol ReuseIdentifiable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UIView: ReuseIdentifiable {}
