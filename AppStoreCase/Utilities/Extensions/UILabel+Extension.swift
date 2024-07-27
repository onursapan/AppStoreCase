//
//  UILabel+Extension.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit.UILabel

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

