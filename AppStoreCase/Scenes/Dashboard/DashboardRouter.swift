//
//  DashboardRouter.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit

protocol DashboardRouterProtocol: AnyObject {
    
    func toDetail(id: String)
}

final class DashboardRouter: DashboardRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func toDetail(id: String) {
        
    }
}
