//
//  GetButton.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SnapKit

final class GetButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setTitle("GET", for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 14)
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 16
        self.isEnabled = false
        
        self.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
    }
}
