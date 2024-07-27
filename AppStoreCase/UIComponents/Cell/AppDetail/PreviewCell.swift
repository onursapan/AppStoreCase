//
//  PreviewCell.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SnapKit

final class PreviewCell: UICollectionViewCell {
    
    static let identifier = "PreviewCell"
    
    private var app: SearchResult?
    
    private lazy var previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    
    private lazy var collectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUiElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure & Design UI
    private func configureUiElements() {
        contentView.addSubview(previewLabel)
        previewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(0)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
        }
        
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
        }
        collectionView.register(PreviewScreenshotsCell.self, forCellWithReuseIdentifier: PreviewScreenshotsCell.identifier)
    }
    
    internal func design(app: SearchResult) {
        self.app = app
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension PreviewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.app?.results.first?.screenshotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewScreenshotsCell.identifier, for: indexPath) as? PreviewScreenshotsCell else { return UICollectionViewCell() }
        cell.design(screenShot: self.app?.results.first?.screenshotUrls?[indexPath.item] ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: collectionView.frame.height)
    }
    
}
