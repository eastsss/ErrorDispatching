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
    
    let dispatcher: ErrorDispatcher = ErrorDispatcher(
        proposer: MyAppEmptyProposer(),
        modifier: nil,
        trailingProposer: .debug
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.showSystemAlert(with: config)
        default:
            return
        }
    }
}
