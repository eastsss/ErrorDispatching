//
//  MoyaNSURLErrorExtractor.swift
//  Pods
//
//  Created by Anatoliy Radchenko on 08/03/2017.
//
//

import Foundation
import Moya

open class MoyaNSURLErrorExtractor: ErrorModifying {
    public init() {}
    
    public func modify(error: Swift.Error) -> Swift.Error? {
        guard let moyaError = error as? MoyaError else {
            return nil
        }
        
        switch moyaError {
        case .underlying(let underlyingError):
            let nsError = underlyingError as NSError
            
            guard nsError.domain == NSURLErrorDomain else {
                return nil
            }
            
            return nsError
        default:
            return nil
        }
    }
}
