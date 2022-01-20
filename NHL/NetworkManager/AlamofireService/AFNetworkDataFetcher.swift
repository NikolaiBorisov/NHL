//
//  AFNetworkDataFetcher.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 05.01.2022.
//

import Foundation

/// Protocol contains method for fetching JSONData
protocol AFDataFetcher {
    func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, Error>) -> Void)
}

/// Class decodes and fetches JSONData. Inherits DataFetcher protocol
final class AFNetworkDataFetcher: AFDataFetcher {
    
    // MARK: - Private Properties
    
    private var afService: AFServiceProtocol
    private var internetService: InternetAvailabilityProtocol
    
    private lazy var decoder: JSONDecoder = {
        return $0
    }(JSONDecoder())
    
    // MARK: - Initializers
    
    init(
        afService: AFServiceProtocol = AFService(),
        internetService: InternetAvailabilityProtocol = InternetAvailabilityService()
    ) {
        self.afService = afService
        self.internetService = internetService
    }
    
    // MARK: - Public Methods
    
    /// Method fetches JSONData
    public func fetchJSONData<T: Codable>(urlString: String, completion: @escaping (Result<T?, Error>) -> Void) {
        guard internetService.isInternetAvailable() else {
            completion(.failure(AppError.noInternetConnection))
            return
        }
        afService.request(with: urlString) { result in
            switch result {
            case .success(let data):
                let decoded = self.decodeJSON(type: T.self, from: data, completion: completion)
                completion(.success(decoded))
            case .failure(_):
                completion(.failure(AppError.badURL))
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Method decodes JSON file
    private func decodeJSON<T: Codable>(type: T.Type, from: Data?, completion: @escaping (Result<T?, Error>) -> Void) -> T? {
        guard let data = from else {
            completion(.failure(AppError.noData))
            return nil
        }
        do {
            let objects = try decoder.decode(type.self, from: data)
            completion(.success(objects))
            return objects
        } catch let jsonError {
            print(AppError.badURL, jsonError)
            completion(.failure(AppError.failedParsingJSON))
            return nil
        }
    }
    
}
