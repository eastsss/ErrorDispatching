//
//  ErrorDispatcherPreferences.swift
//  Pods
//
//  Created by Anatoliy Radchenko on 14/04/2017.
//
//

import Foundation

public extension ErrorDispatcher {
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
    
    public struct Preferences {
        public var trailingProposer: TrailingProposer = .`default`
        
        public init() { }
    }
}
