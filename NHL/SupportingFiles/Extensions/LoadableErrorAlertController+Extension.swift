//
//  LoadableErrorAlertController+Extension.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 29.12.2021.
//

import UIKit

enum AlertConstant {
    static let title = "Oops!"
    static let reload = "Reload"
    static let exit = "Exit"
}

/// Protocol contains method for presenting ErrorAlertController
protocol LoadableErrorAlertController {
    func showErrorAlertWith(
        title: String,
        message: AppError,
        completionReload: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    )
}

// MARK: - Present LoadableErrorAlertController

extension LoadableErrorAlertController where Self: UIViewController {
    
    func showErrorAlertWith(
        title: String,
        message: AppError,
        completionReload: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message.title,
                preferredStyle: .alert
            )
            let resetData = UIAlertAction(
                title: AlertConstant.reload,
                style: .default,
                handler: { _ in
                    completionReload()
                }
            )
            let cancel = UIAlertAction(
                title: AlertConstant.exit,
                style: .destructive,
                handler: { _ in
                    completionCancel()
                }
            )
            alert.addAction(resetData)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
