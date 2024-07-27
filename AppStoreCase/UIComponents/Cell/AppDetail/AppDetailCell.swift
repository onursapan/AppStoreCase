//
//  AppDetailCell.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SnapKit

final class AppDetailCell: UICollectionViewCell {
    
    static let identifier = "AppDetailCell"

    private lazy var iconImageView = UIImageView(cornerRadius: 8)
    
    private lazy var nameLabel = UILabel(text: "App name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var whatsNewLabel = UILabel(text: "whats new", font: .boldSystemFont(ofSize: 20))
    
    private lazy var releaseNotesLabel = UILabel(text: "Release notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI Elements
    private func configureUiElements() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(priceButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(whatsNewLabel)
        contentView.addSubview(releaseNotesLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(140)
        }
        
        priceButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                iconImageView,
                VerticalStackView(arrangedSubviews: [
                    nameLabel,
                    UIStackView(arrangedSubviews: [priceButton, UIView()]),
                    UIView()
                ], spacing: 12)
            ], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel
        ], spacing: 16)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        }
    }
    
    internal func design(app: SearchResult) {
        self.iconImageView.sd_setImage(with: URL(string: app.results.first?.artworkUrl100 ?? ""))
        self.nameLabel.text = app.results.first?.trackName
        self.priceButton.setTitle(app.results.first?.formattedPrice, for: .normal)
        self.releaseNotesLabel.text = app.results.first?.releaseNotes
        self.whatsNewLabel.text = app.results.first?.description
    }
}
