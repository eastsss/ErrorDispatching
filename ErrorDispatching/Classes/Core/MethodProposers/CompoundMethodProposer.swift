//
//  CompoundMethodProposer.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

open class CompoundMethodProposer: MethodProposing {
    private let proposers: [MethodProposing]
    
    public init(proposers: [MethodProposing]) {
        self.proposers = proposers
    }
    
    //MARK: MethodProposing
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        for proposer in proposers {
            if let method = proposer.proposeMethod(toHandle: error) {
                return method
            }
        }
        
        return nil
    }
}
