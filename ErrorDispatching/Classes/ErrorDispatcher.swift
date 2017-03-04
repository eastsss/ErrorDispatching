//
//  ErrorDispatcher.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

final public class ErrorDispatcher {
    public typealias MethodExecutionBlock = ((ErrorHandlingMethod) -> Void)
    
    //MARK: Public properties
    public var execution: MethodExecutionBlock?
    
    //MARK: Private properties
    private let mainProposer: MethodProposing
    
    //MARK: Initializer
    public init(mainProposer: MethodProposing) {
        self.mainProposer = mainProposer
    }
    
    //MARK: Error handling
    public func handle(error: Error) {
        guard let method = mainProposer.proposeMethod(toHandle: error) else {
            print("Unhandled error \(error)")
            return
        }
        
        guard let block = execution else {
            print("Method execution block wasn't initialized, so all errors sent to this dispatcher will be ignored.")
            return
        }
        
        block(method)
    }
}
