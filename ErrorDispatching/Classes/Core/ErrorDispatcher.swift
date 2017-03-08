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
    private let proposer: MethodProposing
    private let modifier: ErrorModifying?
    
    //MARK: Initializer
    public init(proposer: MethodProposing,
                modifier: ErrorModifying? = nil,
                trailingProposer: TrailingProposer = .`default`) {
        switch trailingProposer {
        case .none:
            self.proposer = proposer
        case .`default`:
            self.proposer = CompoundMethodProposer(proposers: [
                proposer,
                DefaultMethodProposer()
            ])
        case .debug:
            self.proposer = CompoundMethodProposer(proposers: [
                proposer,
                DebugMethodProposer()
            ])
        }
        
        self.modifier = modifier
    }
    
    //MARK: Error handling
    public func handle(error: Error) {
        let actualError = modifier?.modify(error: error) ?? error
        
        guard let proposedMethod = proposer.proposeMethod(toHandle: actualError) else {
            print("Unhandled error \(error)")
            return
        }
        
        guard let methodExecutor = executor else {
            print("Executor is nil, all errors sent to this dispatcher will be ignored")
            return
        }
        
        switch proposedMethod {
        case .single(let method):
            methodExecutor.execute(method: method)
        case .compound(let methods):
            for method in methods {
                methodExecutor.execute(method: method)
            }
        }
        
    }
}
