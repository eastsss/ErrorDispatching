//
//  SystemAlertConfiguration.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import UIKit

public struct SystemAlertAction {
    public typealias Handler = ((Void) -> Void)
    
    public let title: String?
    public let style: UIAlertActionStyle
    public let handler: Handler?
    
    public init(title: String?, style: UIAlertActionStyle, handler: Handler? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

public struct SystemAlertConfiguration {
    public let title: String?
    public let message: String?
    public let preferredStyle: UIAlertControllerStyle
    public let actions: [SystemAlertAction]
    
    public init(title: String?, message: String?,
         actions: [SystemAlertAction],
         preferredStyle: UIAlertControllerStyle = .alert) {
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.actions = actions
    }
    
    public init(title: String?, message: String?, actionTitle: String?,
         actionHandler: SystemAlertAction.Handler? = nil) {
        self.title = title
        self.message = message
        self.preferredStyle = .alert
        
        self.actions = [ SystemAlertAction(title: actionTitle, style: .default, handler: actionHandler) ]
    }
}
