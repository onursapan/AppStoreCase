//
//  UIStackView+Extension.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit.UIStackView

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
