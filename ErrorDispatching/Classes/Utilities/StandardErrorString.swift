//
//  StandardErrorString.swift
//  Pods
//
//  Created by Anatoliy Radchenko on 04/03/2017.
//
//

import Foundation

enum LocalizationPrefix: String {
    case title = "com.errordispatching.title"
    case message = "com.errordispatching.message"
    case action = "com.errordispatching.action"
}

class StandardErrorString {
    static func title(forKey key: String) -> String {
        return loadString(for: .title, postfix: key)
    }
    
    static func message(forKey key: String) -> String {
        return loadString(for: .message, postfix: key)
    }
    
    static func action(forKey key: String) -> String {
        return loadString(for: .action, postfix: key)
    }
}

//MARK: Supporting methods
private extension StandardErrorString {
    static func loadString(for prefix: LocalizationPrefix, postfix: String) -> String {
        let framework = Bundle(for: StandardErrorString.self)
        let path = NSURL(fileURLWithPath: framework.resourcePath!).appendingPathComponent("ErrorDispatching.bundle")
        let bundle = Bundle(url: path!)!
        
        let key = "\(prefix.rawValue).\(postfix)"
        return bundle.localizedString(forKey: key, value: nil, table: "StandardErrors")
    }
}
