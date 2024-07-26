//
//  DashboardLauncher.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit

final class DashboardLauncher {
    
    static func start() -> DashboardViewController {
        let view = DashboardViewController()
        let router = DashboardRouter(view: view)
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        
        return view
    }
}
