//
//  AppsService.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

protocol AppsServiceProtocol {
    
   
    func fetchGroupApps(completion: @escaping (Result<[AppGroup]?, ServiceError>) -> Void)
    func fetchAppDetail(id: String, completion: @escaping (Result<SearchResult, ServiceError>) -> Void)
}

final class AppsService {
    
    static let shared = AppsService()
    private let dispatchGroup = DispatchGroup()
    
    private init() {}
}

extension AppsService: AppsServiceProtocol {
     

// MARK: - fetchGroupApps
    func fetchGroupApps(completion: @escaping (Result<[AppGroup]?, ServiceError>) -> Void) {
        var appGroups: [AppGroup] = []
        var groupApp: AppGroup?
        let topPaidUrl =  "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
        
 // MARK: Dispatch Group
  
        dispatchGroup.enter()
        NetworkManager.shared.sendRequest(type: AppGroup.self, url: topPaidUrl, httpMethod: "GET") { [weak self] results in
            guard let self else { return }
            self.dispatchGroup.leave()
            switch results {
            case .success(let apps):
                groupApp = apps
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group = groupApp {
                appGroups.append(group)
            }
            completion(.success(appGroups))
        }
    }
     
    
// MARK: - fetchAppDetail
    func fetchAppDetail(id: String, completion: @escaping (Result<SearchResult, ServiceError>) -> Void) {
        
        let url = "https://itunes.apple.com/lookup?id=\(id)"
        
        NetworkManager.shared.sendRequest(type: SearchResult.self, url: url, httpMethod: "GET") { results in
            switch results {
            case .success(let app):
                completion(.success(app))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
     
}
