//
//  ViewController.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 03/04/2017.
//  Copyright (c) 2017 Anatoliy Radchenko. All rights reserved.
//

import UIKit
import ErrorDispatching

enum MyError: Error {
    case firstCase
    case secondCase
}

class ViewController: UIViewController {

    let dispatcher: ErrorDispatcher = ErrorDispatcher(mainProposer: MyAppMainProposer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatcher.execution = { [unowned self] method in
            switch method {
            case .systemAlert(let config):
                self.showSystemAlert(with: config)
            default:
                return
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatcher.handle(error: MyError.firstCase)
    }
}

