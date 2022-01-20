//
//  AppError.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

enum AppError: Error {
    case failedParsingJSON
    case noInternetConnection
    case serverNotResponding
    case badURL
    case noData
    case somethingWrongWithUrlSessionData
    
    var title: String {
        switch self {
        case .failedParsingJSON:
            return "JSONParsingError".localized()
        case .noInternetConnection:
            return "NoInternetConnection".localized()
        case .serverNotResponding:
            return "ServerIsNotResponding".localized()
        case .badURL:
            return "SomethingWrongWithURLRequest".localized()
        case .noData:
            return "NoData".localized()
        case .somethingWrongWithUrlSessionData:
            return "SomethingWrongWithUrlSessionData".localized()
        }
    }
}
