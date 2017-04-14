//
//  ExampleViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 03/04/2017.
//  Copyright (c) 2017 Anatoliy Radchenko. All rights reserved.
//

import UIKit
import ErrorDispatching

class SimpleExampleViewController: UIViewController {

    var dispatcher: ErrorDispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ErrorDispatcher.preferences.trailingProposer = .default
        
        dispatcher = ErrorDispatcher(proposer: MyAppMainProposer())
        
        dispatcher.executor = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
        dispatcher.handle(error: nsError)
    }
}

//MARK: MethodExecutor
extension SimpleExampleViewController: MethodExecutor {
    func execute(method: ErrorHandlingMethod) {
        switch method {
        case .systemAlert(let config):
            showSystemAlert(with: config)
        default:
            return
        }
    }
}

