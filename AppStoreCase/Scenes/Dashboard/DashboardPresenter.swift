//
//  DashboardPresenter.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

protocol DashboardPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func didSelectApp(id: String)
}

protocol DashboardInteractorOutputs: AnyObject {
    
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
    func onError(message: String)
    func showData(appGroup: [AppGroup])
}

final class DashboardPresenter: DashboardPresenterProtocol {
    
    private weak var view: DashboardViewProtocol?
    private let router: DashboardRouterProtocol
    private let interactor: DashboardInteractorProtocol
        
    init(view: DashboardViewProtocol, router: DashboardRouterProtocol, interactor: DashboardInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareActivityIndicatorView()
        self.interactor.getGroupApps()
    }
    
    func didSelectApp(id: String) {
        self.router.toDetail(id: id)
    }
}

extension DashboardPresenter: DashboardInteractorOutputs {
    
    func beginRefreshing() {
        self.view?.beginRefreshing()
    }
    
    func endRefreshing() {
        self.view?.endRefreshing()
    }
    
    func dataRefreshed() {
        self.view?.dataRefreshed()
    }
    
    func onError(message: String) {
        self.view?.onError(message: message)
    }
    
    func showData(appGroup: [AppGroup]) {
        self.view?.showData(appGroup: appGroup)
    }
}

