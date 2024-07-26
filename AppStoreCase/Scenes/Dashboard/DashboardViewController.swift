//
//  DashboardViewController.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import UIKit
import SnapKit

protocol DashboardViewProtocol: AnyObject {
    
    func prepareCollectionView()
    func prepareActivityIndicatorView()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showData(appGroup: [AppGroup])
}
protocol AppsRowCellDelegate: AnyObject {
    func selectedApp(id: String)
}
 

final class DashboardViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.color = .label
        return aiv
    }()
    
    internal var presenter: DashboardPresenterProtocol!
    private var appGroup: [FeedResult] = []

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if navigationController != nil {
            self.navigationController?.setNavigationBarHidden(true , animated: true)
        }
    }
}

// MARK: - View Protocol
extension DashboardViewController: DashboardViewProtocol {
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AppsRowCell.self, forCellWithReuseIdentifier: AppsRowCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func prepareActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        DispatchQueue.main.async {
            self.showError(message: message)
        }
    }
    
    func showData(appGroup: [AppGroup]) {
        self.appGroup = appGroup.first?.feed.results ?? [FeedResult]()
        
    }
}

// MARK: - DailyListCell Delegate
extension DashboardViewController: AppsRowCellDelegate {
    func selectedApp(id: String) {
        self.presenter.didSelectApp(id: id)
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsRowCell.identifier, for: indexPath) as? AppsRowCell else { return UICollectionViewCell() }
        cell.desing(app: appGroup[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.collectionView.frame.width - 64 , height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = appGroup[indexPath.row].id
        self.presenter.didSelectApp(id: appId)
    }
    
     
}


