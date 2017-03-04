//
//  ErrorHandlingMethod.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

//TODO: add different return types - immediate return, delayed return, return on completion block, etc
public protocol CustomHandlingMethod {}

public enum ErrorHandlingMethod {
    case ignore
    case logout
    case systemAlert(SystemAlertConfiguration)
    case custom(CustomHandlingMethod)
    case compound([ErrorHandlingMethod])
}


