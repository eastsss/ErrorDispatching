//
//  ReactiveErrorDispatcher.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 05/03/2017.
//
//

import Foundation
import ReactiveSwift
import Result

open class ReactiveErrorDispatcher: ErrorDispatcher {
    public let methodExecution: Signal<ErrorHandlingMethod, NoError>
    
    fileprivate let methodExecutionObserver: Signal<ErrorHandlingMethod, NoError>.Observer
    
    override public init(proposer: MethodProposing,
                         modifier: ErrorModifying? = nil) {
        (methodExecution, methodExecutionObserver) = Signal<ErrorHandlingMethod, NoError>.pipe()
        
        super.init(
            proposer: proposer,
            modifier: modifier
        )
        
        self.executor = self
    }
}

//MARK: MethodExecutor
extension ReactiveErrorDispatcher: MethodExecutor {
    public func execute(method: ErrorHandlingMethod) {
        methodExecutionObserver.send(value: method)
    }
}
