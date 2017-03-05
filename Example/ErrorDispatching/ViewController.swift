//
//  ViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 03/04/2017.
//  Copyright (c) 2017 Anatoliy Radchenko. All rights reserved.
//

import UIKit
import ErrorDispatching
import ReactiveSwift

enum MyError: Error {
    case someError
}

class ViewController: UIViewController {

    let dispatcher: ErrorDispatcher = ErrorDispatcher(mainProposer: MyAppMainProposer())
    let reactiveDispatcher: ReactiveErrorDispatcher = ReactiveErrorDispatcher(mainProposer: MyAppMainProposer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dispatcher.executor = self
        
        reactiveDispatcher.methodExecution.producer
            .observe(on: UIScheduler())
            .on(value: { [weak self] method in
                self?.execute(method: method)
            })
            .start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Uncomment to test */
        //dispatcher.handle(error: MyError.someError)
        
        let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
        //dispatcher.handle(error: nsError)
        
        reactiveDispatcher.handle(error: nsError)
    }
}

//MARK: MethodExecutor
extension ViewController: MethodExecutor {
    func execute(method: ErrorHandlingMethod) {
        switch method {
        case .systemAlert(let config):
            self.showSystemAlert(with: config)
        default:
            return
        }
    }
}

