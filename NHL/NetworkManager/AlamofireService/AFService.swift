//
//  AFService.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 05.01.2022.
//

import UIKit
import Alamofire

/// Protocol contains method for requesting data using urlString
protocol AFServiceProtocol {
    func request(with url: String, completion: @escaping (Result<Data?, Error>) -> Void)
}

/// Class contains method for requesting data
final class AFService: AFServiceProtocol {
    
    // MARK: - Public Methods
    
    func request(with url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
}
