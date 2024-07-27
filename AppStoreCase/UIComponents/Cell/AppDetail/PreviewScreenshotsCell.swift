//
//  PreviewScreenshotsCell.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SnapKit

class PreviewScreenshotsCell: UICollectionViewCell {
    
    static let identifier = "PreviewScreenshotsCell"
    
    private lazy var screenshotImageView = UIImageView(cornerRadius: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUiElements() {
        contentView.addSubview(screenshotImageView)
        
        screenshotImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    internal func design(screenShot: String) {
        self.screenshotImageView.sd_setImage(with: URL(string: screenShot))
    }
}

