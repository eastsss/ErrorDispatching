//
//  CompoundErrorModifier.swift
//  Pods
//
//  Created by Anatoliy Radchenko on 08/03/2017.
//
//

import Foundation

open class CompoundErrorModifier: ErrorModifying {
    private let modifiers: [ErrorModifying]
    
    public init(modifiers: [ErrorModifying]) {
        self.modifiers = modifiers
    }
    
    //MARK: ErrorModifying
    public func modify(error: Error) -> Error? {
        for modifier in modifiers {
            if let modifiedError = modifier.modify(error: error) {
                return modifiedError
            }
        }
        
        return nil
    }
}
