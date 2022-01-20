//
//  LoadableGameIDAlertController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 11.01.2022.
//

import UIKit

enum ConvAlertConstant {
    static let title = "No Data to search for!"
    static let message = "Please, make sure you have entered Game Year, Game Type and Game Number correctly\nand try again"
    static let ok = "Ok"
    static let key = "attributedTitle"
}

fileprivate enum GameIDAlertConstant {
    static let title = "Enter the Year, Game Type and Game Number"
    static let message = "\n1. Enter the year\n(e.g. 2017) 4 digits\nFrom 2010 till now\n\n2. Enter the game type,\nwhere 01 = preseason,\n02 = regular season\n(e.g. 02) 2 digits\n\n3. Enter a specific game number\n(e.g. 0001) 4 digits"
    static let proceed = "Proceed"
    static let cancel = "Cancel"
    static let yearTextField = "1. Year starts from 2010 (4 digits)"
    static let gameTypeTextField = "2. Enter 01 or 02"
    static let gameNumberTextField = "3. Enter the game number (4 digits)"
}

/// Protocol contains method for presenting LoadableGameIDAlertController
protocol LoadableGameIDAlertController {
    func showGameIDAlert(
        completionProceed: @escaping (Int, String, String, String) -> Void?,
        completionCancel: @escaping () -> Void?
    )
}

// MARK: - Present LoadableGameIDController

extension LoadableGameIDAlertController where Self: UIViewController {
    
    func showGameIDAlert(
        completionProceed: @escaping (Int, String, String, String) -> Void?,
        completionCancel: @escaping () -> Void?
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: GameIDAlertConstant.title,
                message: GameIDAlertConstant.message,
                preferredStyle: .alert
            )
            let proceed = UIAlertAction(
                title: GameIDAlertConstant.proceed,
                style: .default,
                handler: { _ in
                    guard let gameYear = alert.textFields?.first?.text, !gameYear.isEmpty,
                          let gameType = alert.textFields?[1].text, !gameType.isEmpty,
                          let gameNumber = alert.textFields?.last?.text, !gameNumber.isEmpty,
                          let gameID = Int(gameYear + gameType + gameNumber) else {
                              self.showConvenienceAlert(completion: completionProceed)
                              return
                          }
                    completionProceed(gameID, gameYear, gameType, gameNumber)
                }
            )
            let cancel = UIAlertAction(
                title: GameIDAlertConstant.cancel,
                style: .destructive,
                handler: { _ in
                    completionCancel()
                }
            )
            alert.addAction(proceed)
            alert.addAction(cancel)
            alert.addTextField { textField1 in
                textField1.placeholder = GameIDAlertConstant.yearTextField
                textField1.keyboardType = .numberPad
                textField1.clearButtonMode = .always
            }
            alert.addTextField { textField2 in
                textField2.placeholder = GameIDAlertConstant.gameTypeTextField
                textField2.keyboardType = .numberPad
                textField2.clearButtonMode = .always
            }
            alert.addTextField { textField3 in
                textField3.placeholder = GameIDAlertConstant.gameNumberTextField
                textField3.keyboardType = .numberPad
                textField3.clearButtonMode = .always
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Private Methods
    
    /// Call when user didn't enter needed data
    private func showConvenienceAlert(completion: @escaping (Int, String, String, String) -> Void?) {
        let alert = UIAlertController(
            title: ConvAlertConstant.title,
            message: ConvAlertConstant.message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: ConvAlertConstant.ok, style: .default) { _ in
            self.showGameIDAlert(completionProceed: completion, completionCancel: {})
        }
        alert.addAction(okAction)
        guard let title = alert.title else { return }
        alert.setValue(NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                NSAttributedString.Key.foregroundColor: UIColor.systemRed
            ]
        ), forKey: ConvAlertConstant.key)
        self.present(alert, animated: true, completion: nil)
    }
    
}
