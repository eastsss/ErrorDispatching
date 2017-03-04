//
//  MethodProposing.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public protocol MethodProposing {
    func proposeMethod(toHandle error: Error) -> ErrorHandlingMethod?
}
