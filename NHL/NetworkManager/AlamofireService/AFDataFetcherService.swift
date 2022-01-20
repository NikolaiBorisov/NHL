//
//  AFDataFetcherService.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 05.01.2022.
//

import UIKit

/// Protocol contains method for fetching data
protocol AFDataFetcherServiceProtocol {
    func fetchTeams(completion: @escaping (Result<NHLDTO?, Error>) -> Void)
    func fetchPlayerInfo(for id: Int, completion: @escaping (Result<PlayerDTO?, Error>) -> Void)
    func fetchGameInfo(for id: Int, completion: @escaping (Result<GameDTO?, Error>) -> Void)
}

/// Class fetches data from DTOModel
final class AFDataFetcherService: AFDataFetcherServiceProtocol {
    
    // MARK: - Private Properties
    
    private var afDataFetcher: AFDataFetcher
    
    // MARK: - Initializers
    
    init(afDataFetcher: AFDataFetcher = AFNetworkDataFetcher()) {
        self.afDataFetcher = afDataFetcher
    }
    
    /// Method fetches teams using URL
    public func fetchTeams(completion: @escaping (Result<NHLDTO?, Error>) -> Void) {
        let url = AppURL.teamURL
        afDataFetcher.fetchJSONData(urlString: url, completion: completion)
    }
    
    /// Method fetches player info using URL
    public func fetchPlayerInfo(for id: Int, completion: @escaping (Result<PlayerDTO?, Error>) -> Void) {
        let url = AppURL.detailedPlayerURL(id)
        afDataFetcher.fetchJSONData(urlString: url, completion: completion)
    }
    
    /// Method fetches game info using URL
    public func fetchGameInfo(for id: Int, completion: @escaping (Result<GameDTO?, Error>) -> Void) {
        let url = AppURL.gameURL(id)
        afDataFetcher.fetchJSONData(urlString: url, completion: completion)
    }
}
