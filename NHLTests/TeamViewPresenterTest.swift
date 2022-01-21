//
//  TeamViewPresenterTest.swift
//  NHLTests
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import XCTest
@testable import NHL

class TeamViewPresenterTest: XCTestCase {
    
    var viewMock = TeamViewMock()
    var presenter: TeamPresenterOutputDelegate {
        let presenter = TeamPresenterMock()
        presenter.delegate = viewMock
        return presenter
    }
    
    func testGetData() {
        
        presenter.getDataWithAF()
        
        XCTAssertTrue(viewMock.isStart)
        XCTAssertTrue(viewMock.isStop)
        XCTAssertTrue(viewMock.isEndRefreshing)
        XCTAssertTrue(viewMock.isReload)
        XCTAssertTrue(viewMock.isAlertShown)
        XCTAssertTrue(viewMock.isLabelSet)
        // XCTAssertTrue(viewMock.isNextVCShown)
    }
    
}

final class TeamViewMock: TeamPresenterInputDelegate {
    
    var isStart = false
    var isStop = false
    var isEndRefreshing = false
    var isReload = false
    var isAlertShown = false
    var isLabelSet = false
    var isNextVCShown = false
    
    func setupLabel(with text: String) {
        self.isLabelSet = true
    }
    
    func presentErrorAlertWith(title: String, message: AppError) {
        self.isAlertShown = true
    }
    
    func showNextVCWith(team: DetailedTeamScreenModelProtocol) {
        self.isNextVCShown = true
    }
    
    func startAnimating() {
        self.isStart = true
    }
    
    func stopAnimating() {
        self.isStop = true
    }
    
    func endRefreshing() {
        self.isEndRefreshing = true
    }
    
    func reloadView(_ teams: NHLDTO) {
        self.isReload = true
    }
    
}

final class TeamPresenterMock: TeamPresenterOutputDelegate {
    
    var delegate: TeamPresenterInputDelegate?
    var dataFetcherService = DataFetcherServiceMock()
    
    func getDataWithAF() {
        delegate?.startAnimating()
        dataFetcherService.fetchTeams { [weak self] result in
            switch result {
            case .success:
                guard let delegate = self?.delegate else { return }
                delegate.setupLabel(with: "")
                delegate.stopAnimating()
                delegate.endRefreshing()
                delegate.reloadView(NHLDTO(copyright: "", teams: []))
            case .failure:
                self?.delegate?.presentErrorAlertWith(title: "", message: .noData)
                return
            }
        }
    }
    
    func didTapOn(team: DetailedTeamScreenModelProtocol) {
        delegate?.showNextVCWith(team: team)
    }
    
}

final class DataFetcherServiceMock: AFDataFetcherServiceProtocol {
    
    func fetchTeams(completion: @escaping (Result<NHLDTO?, Error>) -> Void) {
        completion(.success(NHLDTO(copyright: "", teams: [])))
        completion(.failure(AppError.noData))
    }
    
    func fetchPlayerInfo(for id: Int, completion: @escaping (Result<PlayerDTO?, Error>) -> Void) {}
    func fetchGameInfo(for id: Int, completion: @escaping (Result<GameDTO?, Error>) -> Void) {}
    
}
