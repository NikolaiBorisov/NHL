//
//  LoadableInfoAlertController.swift
//  NHL
//
//  Created by NIKOLAI BORISOV on 18.01.2022.
//

import UIKit

enum InfoAlertConstant {
    static let title1 = "Would You Like to Save this Photo?"
    static let title2 = "Photo Successfully Saved to Favorites"
    static let message1 = "Photo Will Be Saved to Favorites"
    static let message2 = "Open Favorites?"
    static let proceed = "Proceed"
    static let cancel = "Cancel"
    static let titleKey = "attributedTitle"
    static let messageKey = "attributedMessage"
}


/// Protocol contains method for presenting InfoAlertController
protocol LoadableInfoAlertController {
    func showInfoAlertWith(
        title: String,
        message: String,
        completionOK: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    )
}

// MARK: - Present LoadableInfoAlertController

extension LoadableInfoAlertController where Self: UIViewController {
    
    func showInfoAlertWith(
        title: String,
        message: String,
        completionOK: @escaping () -> Void?,
        completionCancel: @escaping () -> Void?
    ) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            let okButton = UIAlertAction(
                title: InfoAlertConstant.proceed,
                style: .default,
                handler: { _ in
                    completionOK()
                }
            )
            let cancelButton = UIAlertAction(
                title: InfoAlertConstant.cancel,
                style: .destructive,
                handler: { _ in
                    completionCancel()
                }
            )
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            alert.view.tintColor = .cyan
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
            
            alert.setValue(NSAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.avenirNextMediumOfSize(16),
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]), forKey: InfoAlertConstant.messageKey)
            
            alert.setValue(NSAttributedString(
                string: title,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan]
            ), forKey: InfoAlertConstant.titleKey)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
