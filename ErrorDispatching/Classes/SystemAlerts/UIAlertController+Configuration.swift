//
//  UIAlertController+Configuration.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import UIKit

public extension UIAlertController {
    public convenience init(configuration: SystemAlertConfiguration, dismissHandler: ((Void) -> Void)? = nil) {
        self.init(
            title: configuration.title,
            message: configuration.message,
            preferredStyle: configuration.preferredStyle
        )
        
        for action in configuration.actions {
            let alertAction = UIAlertAction(
                title: action.title,
                style: action.style,
                handler: { _ in
                    action.handler?()
                    dismissHandler?()
            })
            
            addAction(alertAction)
        }
    }
}
