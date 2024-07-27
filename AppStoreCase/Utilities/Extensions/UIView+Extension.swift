//
//  UIView+Extension.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    
    func anchor(top: ConstraintRelatableTarget? = nil,
                leading: ConstraintRelatableTarget? = nil,
                trailing: ConstraintRelatableTarget? = nil,
                bottom: ConstraintRelatableTarget? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        self.snp.makeConstraints { make in
            if let top = top {
                make.top.equalTo(top).offset(padding.top)
            }
            
            if let leading = leading {
                make.leading.equalTo(leading).offset(padding.left)
            }
            
            if let trailing = trailing {
                make.trailing.equalTo(trailing).offset(-padding.right)
            }
            
            if let bottom = bottom {
                make.bottom.equalTo(bottom).offset(-padding.bottom)
            }
            
            if size.width != 0 {
                make.width.equalTo(size.width)
            }
            
            if size.height != 0 {
                make.height.equalTo(size.height)
            }
        }
    }
    
    func anchorSize(to view: UIView) {
        self.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
    }
}
