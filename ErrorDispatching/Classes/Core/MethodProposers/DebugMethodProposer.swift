//
//  DebugMethodProposer.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public class DebugMethodProposer: MethodProposing {
    public init() {}
    
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        let format = StandardErrorString.message(forKey: "debug-format")
        let message = String(format: format, "\(error)")
        
        let config = SystemAlertConfiguration(
            title: StandardErrorString.title(forKey: "debug"),
            message: message,
            actionTitle: StandardErrorString.action(forKey: "ok")
        )
        
        return .single(.systemAlert(config))
    }
}
