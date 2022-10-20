import UIKit

/// Main Object that used in navigation. Have many different types of presentation and inner methods to manipulate navigation stack.
/// Work on states with associated values.
/// - Note use **actionReducer(action:)** function with some action to change state of navigation stack. It's trigger inner function to change navigation screen.
/// - Note use **start()** function to trigger first default screen or **actionReducer(action:)** with **restruct** action to set up inital navigation stack state.
public protocol Coordinator: AnyObject {
    func actionReducer(action: Navigation.Action)
    func start()
}
