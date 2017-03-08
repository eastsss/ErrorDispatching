//
//  UnderlyingErrorExampleViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 08/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import ErrorDispatching
import Moya

class UnderlyingErrorExampleViewController: UIViewController {
    let dispatcher: ErrorDispatcher = ErrorDispatcher(
        proposer: MyAppMainProposer(),
        modifier: MoyaNSURLErrorExtractor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatcher.executor = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
        let wrappedError = MoyaError.underlying(nsError)
        dispatcher.handle(error: wrappedError)
    }
}

//MARK: MethodExecutor
extension UnderlyingErrorExampleViewController: MethodExecutor {
    func execute(method: ErrorHandlingMethod) {
        switch method {
        case .systemAlert(let config):
            self.showSystemAlert(with: config)
        default:
            return
        }
    }
}
