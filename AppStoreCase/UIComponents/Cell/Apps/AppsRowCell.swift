//
//  AppsRowCell.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SDWebImage
import SnapKit

final class AppsRowCell: UICollectionViewCell {
    
    static let identifier = "AppsRowCell"
    
    private lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        return imageView
    }()
    
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var getButton = GetButton()
    weak var delegate: AppsRowCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure & Design UI
    private func configureUIElements() {
        let stackView = UIStackView(arrangedSubviews: [appImageView,
                                                       VerticalStackView(arrangedSubviews: [appNameLabel, companyNameLabel]),
                                                       getButton])
        
        stackView.spacing = 16
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    internal func desing(app: FeedResult) {
        self.appNameLabel.text = app.name
        self.companyNameLabel.text = app.artistName
        self.appImageView.sd_setImage(with: URL(string: app.artworkUrl100))
    }
}
