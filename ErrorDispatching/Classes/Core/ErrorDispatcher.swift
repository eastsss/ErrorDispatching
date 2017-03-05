//
//  ErrorDispatcher.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public protocol MethodExecutor: class {
    func execute(method: ErrorHandlingMethod)
}

open class ErrorDispatcher {
    public enum TrailingProposer {
        /**
            No trailing proposer will be used.
         */
        case none
        
        /**
            DefaultMethodProposer will be used as trailing one, thereby all unhandled errors will be
            handled by showing system alert with generic message.
         */
        case `default`
        
        /**
            DebugMethodProposer will be used as trailing one, thereby all unhandled errors will be
            handled by showing system alert with error details.
         */
        case debug
    }
    
    public weak var executor: MethodExecutor?
    
    //MARK: Private properties
    private let mainProposer: MethodProposing
    
    //MARK: Initializer
    public init(mainProposer: MethodProposing,
                trailingProposer: TrailingProposer = .`default`) {
        switch trailingProposer {
        case .none:
            self.mainProposer = mainProposer
        case .`default`:
            self.mainProposer = CompoundMethodProposer(proposers: [
                mainProposer,
                DefaultMethodProposer()
            ])
        case .debug:
            self.mainProposer = CompoundMethodProposer(proposers: [
                mainProposer,
                DebugMethodProposer()
            ])
        }
    }
    
    //MARK: Error handling
    public func handle(error: Error) {
        guard let method = mainProposer.proposeMethod(toHandle: error) else {
            print("Unhandled error \(error)")
            return
        }
        
        guard let methodExecutor = executor else {
            print("Executor is nil, all errors sent to this dispatcher will be ignored")
            return
        }
        
        methodExecutor.execute(method: method)
    }
}
