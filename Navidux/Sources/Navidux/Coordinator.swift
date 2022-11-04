import UIKit

/// Main Object that used in navigation. Have many different types of presentation and inner methods to manipulate navigation stack.
/// Work on states with associated values.
/// - Note use **actionReducer(action:)** function with some action to change state of navigation stack. It's trigger inner function to change navigation screen.
public protocol Coordinator: AnyObject {
    func actionReducer(action: Navigation.Action)
}
