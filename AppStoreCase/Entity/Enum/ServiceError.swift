//
//  ServiceError.swift
//  AppStoreCase
//
//  Created by Onur Sapan on 27.07.2024.
//

import Foundation

enum ServiceError: Error {
    
    case invalidURL(Error)
    case noData
    case statusCode(code: Int)
}
