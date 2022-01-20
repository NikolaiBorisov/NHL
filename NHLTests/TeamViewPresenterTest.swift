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
        
        presenter.getDataWithDataFetcher()
        
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
    
    func showNextVCWith(model: DetailedTeamModel) {
        self.isNextVCShown = true
    }
    
    func presentErrorAlertWith(title: String, message: AppError) {
        isAlertShown = true
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
    
    func getDataWithDataFetcher() {
        delegate?.startAnimating()
        dataFetcherService.fetchTeamData { [weak self] result in
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
    
    func getDataWithAF() {}
    
    func didTapOn(team: Team, with icon: UIImage?) {
        let model = DetailedTeamModel(
            title: "",
            icon: icon,
            fullName: "",
            city: "",
            timeZone: "",
            abbreviation: "",
            firstYearOfPlay: "",
            division: "",
            conference: "",
            venue: "",
            officialSite: "",
            numberOfRows: 1
        )
        delegate?.showNextVCWith(model: model)
    }
    
}

final class DataFetcherServiceMock: DataFetcherServiceProtocol {
    
    func fetchTeamData(completion: @escaping (Result<NHLDTO?, AppError>) -> Void) {
        completion(.success(NHLDTO(copyright: "", teams: [])))
        completion(.failure(.noInternetConnection))
    }
    
}
