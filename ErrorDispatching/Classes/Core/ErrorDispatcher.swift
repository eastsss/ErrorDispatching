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
    public static var preferences: Preferences = Preferences()
    
    public weak var executor: MethodExecutor?
    
    //MARK: Private properties
    private let proposer: MethodProposing
    private let modifier: ErrorModifying?
    private let _preferences: Preferences
    
    //MARK: Initializer
    public init(proposer: MethodProposing,
                modifier: ErrorModifying? = nil) {
        //making a copy of shared preferences to use in this dispatcher
        _preferences = type(of: self).preferences
        
        switch _preferences.trailingProposer {
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
