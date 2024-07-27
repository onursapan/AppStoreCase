//
//  AppDetailRouter.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation
import UIKit

protocol AppDetailRouterProtocol: AnyObject {
    
}

final class AppDetailRouter: AppDetailRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

