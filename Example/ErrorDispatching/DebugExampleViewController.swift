//
//  DebugExampleViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 08/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ErrorDispatching

class DebugExampleViewController: UIViewController {
    
    var dispatcher: ErrorDispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ErrorDispatcher.preferences.trailingProposer = .debug
        
        dispatcher = ErrorDispatcher(
            proposer: MyAppEmptyProposer(),
            modifier: nil
        )
        
        dispatcher.executor = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost, userInfo: nil)
        dispatcher.handle(error: nsError)
    }
}

//MARK: MethodExecutor
extension DebugExampleViewController: MethodExecutor {
    func execute(method: ErrorHandlingMethod) {
        switch method {
        case .systemAlert(let config):
            showSystemAlert(with: config)
        default:
            return
        }
    }
}
