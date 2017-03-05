//
//  UIViewController+SystemAlert.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import UIKit

public extension UIViewController {
    public func showSystemAlert(with configuration: SystemAlertConfiguration) {
        let alert = UIAlertController(configuration: configuration)
        present(alert, animated: true, completion: nil)
    }
}
