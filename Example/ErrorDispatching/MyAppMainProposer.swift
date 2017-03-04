//
//  MyAppMainProposer.swift
//  ErrorDispatching
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import ErrorDispatching

class MyAppMainProposer: CompoundMethodProposer {
    init() {
        super.init(proposers: [ DebugMethodProposer() ])
    }
}
