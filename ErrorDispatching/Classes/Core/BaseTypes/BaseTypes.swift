//
//  ErrorHandlingMethod.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public protocol CustomHandlingMethod {}

public enum Proposition {
    case single(ErrorHandlingMethod)
    case compound([ErrorHandlingMethod])
}

public enum ErrorHandlingMethod {
    case ignore
    case logout
    case systemAlert(SystemAlertConfiguration)
    case custom(CustomHandlingMethod)
}

public protocol MethodProposing {
    func proposeMethod(toHandle error: Error) -> Proposition?
}


