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
    /**
        Returns nil if this proposer can't propose method to handle this error.
    */
    func proposeMethod(toHandle error: Error) -> Proposition?
}

public protocol ErrorModifying {
    /**
        Returns modified error or nil/the same error if error shouldn't be modified. 
        Can be used in cases where you need to extract underlying error from nested error types.
        Example: If you using Moya for network requests, it can wrap standard NSError's into it's own error (.underlying), 
        so you can use this protocol to unwrap the error and handle it as general NSError, using the same proposer class.
    */
    func modify(error: Error) -> Error?
}


