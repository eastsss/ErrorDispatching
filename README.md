# ErrorDispatching

[![CI Status](http://img.shields.io/travis/eastsss/ErrorDispatching.svg?style=flat)](https://travis-ci.org/eastsss/ErrorDispatching)
[![Version](https://img.shields.io/cocoapods/v/ErrorDispatching.svg?style=flat)](http://cocoapods.org/pods/ErrorDispatching)
[![Swift v4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/cocoapods/l/ErrorDispatching.svg?style=flat)](http://cocoapods.org/pods/ErrorDispatching)
[![Platform](https://img.shields.io/cocoapods/p/ErrorDispatching.svg?style=flat)](http://cocoapods.org/pods/ErrorDispatching)


## What is this?

A small library which simplifies error handling code in your view controllers/view models by using `Chain of Responsibility` pattern. It also allows you to reuse error handling code if you need the same behavior in another project.

## How it works?

One of the main things here are so called "proposers". Every proposer usually takes one specific type of error as an input and proposes method to handle this error - for example, "Show a system alert", or passes this error down by hierarchy. Executing this method(e.g. showing a system alert) is completely up to you. 

Handling your own custom errors is pretty simple - create a class which implements `MethodProposing` protocol and return correct "proposition" for your errors: 

```swift
enum MyCustomError: Swift.Error {
    case somethingBadHappened
}

class MyProposer: MethodProposing {
    func proposeMethod(toHandle error: Error) -> Proposition? {
        guard let myCustomError = error as? MyCustomError else {
            return nil
        }
        
        let config = SystemAlertConfiguration(
            title: "Error",
            message: "Oops! Something went wrong",
            actionTitle: "OK"
        )
        
        return .single(.systemAlert(config))
    }
}
```

Then you can pass this proposer to ErrorDispatcher initializator, as well as any other proposers you need: 

```swift
let compoundProposer = CompoundMethodProposer(proposers: [
    MyProposer(),
    NSURLErrorMethodProposer()
])
let dispatcher: ErrorDispatcher = ErrorDispatcher(proposer: compoundProposer)
```

To execute proposed methods, you should implement `MethodExecutor` protocol. This is a callback which will be called when dispatcher found a "method" to handle this error. Example:
```swift
extension ExampleViewController: MethodExecutor {
    func execute(method: ErrorHandlingMethod) {
        switch method {
        case .systemAlert(let config):
            showSystemAlert(with: config)
        default:
            return
        }
    }
}
```

After that you can use ErrorDispatcher to handle your errors as following:
```swift
dispatcher.executor = self

let nsError = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
dispatcher.handle(error: nsError)
```

## Example

Just launch `Example/ErrorDispatching.xcworkspace`, build and run. Cocoapods are already installed.


## Installation

ErrorDispatching is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ErrorDispatching"
```

## Versions

| Swift Version  | Pod Version |
| ----- | ----- |
| 3.0  | 0.1.3+  |
| 4.0  | 0.2.0+  |

## TODO

- Add more built-in proposers for system errors
- More localizations as well


## Author

Anatoliy Radchenko, anatox91@yandex.ru

## License

ErrorDispatching is available under the MIT license. See the LICENSE file for more info.

