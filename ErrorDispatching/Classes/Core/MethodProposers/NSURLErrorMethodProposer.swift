//
//  NSURLErrorMethodProposer.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

public class NSURLErrorMethodProposer: MethodProposing {
    public init() {}
    
    public func proposeMethod(toHandle error: Error) -> Proposition? {
        let nsError = error as NSError
        
        guard nsError.domain == NSURLErrorDomain else {
            return nil
        }
        
        switch nsError.code {
        case NSURLErrorCancelled:
            return .single(.ignore)
        case NSURLErrorCannotFindHost, NSURLErrorDNSLookupFailed:
            return systemAlertMethod(withMessageKey: "cant-find-host")
        case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost,
             NSURLErrorResourceUnavailable, NSURLErrorRedirectToNonExistentLocation:
            return systemAlertMethod(withMessageKey: "resource-unavailable")
        case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
            return systemAlertMethod(withMessageKey: "internet-connection-lost")
        default:
            return nil
        }
    }
}

//MARK: Supporting methods
private extension NSURLErrorMethodProposer {
    func systemAlertMethod(withMessageKey key: String) -> Proposition {
        let config = SystemAlertConfiguration(
            title: StandardErrorString.title(forKey: "default"),
            message: StandardErrorString.message(forKey: key),
            actionTitle: StandardErrorString.action(forKey: "ok")
        )
        
        return .single(.systemAlert(config))
    }
}
