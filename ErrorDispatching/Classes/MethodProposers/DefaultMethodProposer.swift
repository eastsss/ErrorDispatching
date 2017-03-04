//
//  DefaultMethodProposer.swift
//  Pods
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public class DefaultMethodProposer: MethodProposing {
    public init() {}
    
    public func proposeMethod(toHandle error: Error) -> ErrorHandlingMethod? {
        let config = SystemAlertConfiguration(
            title: StandardErrorString.title(forKey: "default"),
            message: StandardErrorString.message(forKey: "generic"),
            actionTitle: StandardErrorString.action(forKey: "ok")
        )
        
        return .systemAlert(config)
    }
}
