//
//  DashboardLauncher.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

final class DashboardLauncher {
    
    static func start() -> DashboardViewController {
        let view = DashboardViewController()
        let router = DashboardRouter()
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        
        
        return view
        
    }
}
