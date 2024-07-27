//
//  AppDetailLauncher.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

final class AppDetailLauncher {
    
    static func start(id: String) -> AppDetailViewController {
        let view = AppDetailViewController()
        let router = AppDetailRouter(view: view)
        let interactor = AppDetailInteractor(id: id)
        let presenter = AppDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        return view
    }
}
