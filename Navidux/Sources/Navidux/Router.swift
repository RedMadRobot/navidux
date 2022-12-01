import UIKit

/// Main Object that used in navigation. Have many different types of presentation and inner methods to manipulate navigation stack.
/// Work on states with associated values.
/// - Note use **route(with:)** function with some action to change state of navigation stack. It's trigger inner function to change navigation screen.
public protocol Router: AnyObject {
    func route(with action: Navigation.Action)
}
