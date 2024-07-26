//
//  DashboardInteractor.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

protocol DashboardInteractorProtocol: AnyObject {
    var delegate: DashboardInteractorOutputs? { get set }
    
    func getGroupApps()
}

final class DashboardInteractor: DashboardInteractorProtocol {
    
    weak var delegate: DashboardInteractorOutputs?
    private let service: AppsServiceProtocol
    
    init(service: AppsServiceProtocol = AppsService.shared) {
        self.service = service
    }
    
    func getGroupApps() {
        delegate?.beginRefreshing()
        
        self.service.fetchGroupApps { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            
            switch results {
            case .success(let apps):
                self.delegate?.showData(appGroup: apps ?? [])
                self.delegate?.dataRefreshed()
            case .failure(let error):
                self.delegate?.onError(message: error.localizedDescription)
            }
        }
    }
}

