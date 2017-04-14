//
//  ReactiveSwiftExampleViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 08/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ReactiveSwift
import ErrorDispatching

class ReactiveSwiftExampleViewController: UIViewController {
    var reactiveDispatcher: ReactiveErrorDispatcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ErrorDispatcher.preferences.trailingProposer = .default
        
        reactiveDispatcher = ReactiveErrorDispatcher(proposer: MyAppMainProposer())
        
        reactiveDispatcher.methodExecution
            .observe(on: UIScheduler())
            .observeValues { [weak self] method in
                switch method {
                case .systemAlert(let config):
                    self?.showSystemAlert(with: config)
                default:
                    return
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        reactiveDispatcher.handle(error: nsError)
    }
}
