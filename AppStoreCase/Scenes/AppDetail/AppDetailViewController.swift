//
//  AppDetailViewController.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit

protocol AppDetailViewProtocol: AnyObject {
    func prepareCollectionView()
    func prepareActivityIndicatorView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
}

final class AppDetailViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.color = .label
        return aiv
    }()
    
    internal var presenter: AppDetailPresenterProtocol!

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController != nil {
            self.navigationController?.setNavigationBarHidden(false , animated: true)
        }
    }
}

// MARK: - View Protocol
extension AppDetailViewController: AppDetailViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.identifier)
        self.collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func prepareActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
               activityIndicatorView.snp.makeConstraints { make in
                   make.top.equalTo(view.snp.top)
                   make.leading.equalTo(view.snp.leading)
                   make.trailing.equalTo(view.snp.trailing)
                   make.bottom.equalTo(view.snp.bottom)
               }
    }
    
    func beginRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func dataRefreshed() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func onError(message: String) {
        self.showError(message: message)
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension AppDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.identifier, for: indexPath) as? AppDetailCell else { return UICollectionViewCell() }
            if let app = presenter.app {
                cell.design(app: app)
            }
            return cell
        } else if indexPath.item == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.identifier, for: indexPath) as? PreviewCell else { return UICollectionViewCell() }
            if let app = presenter.app {
                cell.design(app: app)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            // Dynamic size for cell
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            if let app = presenter.app {
                dummyCell.design(app: app)
                dummyCell.layoutIfNeeded()
            }
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            // Dynamic size for cell
            
            return CGSize(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        }
        return .init(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}

