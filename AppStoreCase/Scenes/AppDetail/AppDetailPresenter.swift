//
//  AppDetailPresenter.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

protocol AppDetailPresenterProtocol: AnyObject {
    
    var app: SearchResult? { get }
  
    func viewDidLoad()
}

protocol AppDetailInteractorOutputs: AnyObject {
    func beginRefreshing()
    func endRefreshing()
    func onError(message: String)
    func showApp(app: SearchResult)
     
}

final class AppDetailPresenter: AppDetailPresenterProtocol {
    
    private weak var view: AppDetailViewProtocol?
    private let router: AppDetailRouterProtocol
    private let interactor: AppDetailInteractorProtocol
    
    private(set) internal var app: SearchResult?
    
    init(view: AppDetailViewProtocol, router: AppDetailRouterProtocol, interactor: AppDetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.interactor.delegate = self
    }
    
    func viewDidLoad() {
        self.view?.prepareCollectionView()
        self.view?.prepareActivityIndicatorView()
        self.interactor.getDetail()
    }
}

extension AppDetailPresenter: AppDetailInteractorOutputs {
 
    func beginRefreshing() {
        self.view?.beginRefreshing()
    }
    
    func endRefreshing() {
        self.view?.endRefreshing()
    }

    func onError(message: String) {
        self.view?.onError(message: message)
    }
    
    func showApp(app: SearchResult) {
        self.app = app
        self.view?.dataRefreshed()
    }
     
}
