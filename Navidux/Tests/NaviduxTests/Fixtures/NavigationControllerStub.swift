@testable import Navidux
import UIKit

enum NavigationControllerCallingMethods: Equatable {
    case addToStack(tag: String)
    case removeLastFromStack
    case removeTillFromStack(tag: String)
    case rebuildNavStack(tags: [String])
    case pushViewController(tag: String?)
    case popViewController
    case popToViewController(tag: String?)
    case present(tag: String?)
    case dismiss
}

final class NavigationControllerStub: NavigationController {
    var callingStack: [NavigationControllerCallingMethods] = []
    
    var screens: [any NavigationScreen] = []

    var topScreen: (any NavigationScreen)? = nil
    
    var topViewController: UIViewController? {
        screens.last
    }

    var viewControllers: [UIViewController] = []

    func addToStack(screen: any NavigationScreen) {
        callingStack.append(.addToStack(tag: screen.tag))
    }

    func removeLastFromStack() {
        callingStack.append(.removeLastFromStack)
    }

    func removeTillFromStack(screen: any NavigationScreen) {
        callingStack.append(.removeTillFromStack(tag: screen.tag))
    }

    func rebuildNavStack(with screens: [any NavigationScreen]) {
        callingStack.append(.rebuildNavStack(tags: screens.map { $0.tag }))
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let vcTag = (viewController as? (any NavigationScreen))?.tag
        callingStack.append(.pushViewController(tag: vcTag))
    }
    
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController? {
        callingStack.append(.popViewController)
        return nil
    }
    
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let vcTag = (viewController as? (any NavigationScreen))?.tag
        callingStack.append(.popToViewController(tag: vcTag))
        return nil
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        let vcTag = (viewControllerToPresent as? (any NavigationScreen))?.tag
        callingStack.append(.present(tag: vcTag))
    }
    
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        callingStack.append(.dismiss)
    }
}
