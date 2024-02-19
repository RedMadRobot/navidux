import UIKit

/// NavigationController its abstract object uses for navigation. Its a closest wrapper to UINavigation controller or alternative.
public protocol NavigationController {
    /// - **screens**: return some representation of screen from UINavigationController.viewController. Difference in track screen in navigation stack.
    var screens: [any NavigationScreen] { get set }
    /// - **topScreen**: return screen from top of the
    var topScreen: (any NavigationScreen)? { get }
    
    /// - **addToStack**: method uses to add **NavigationScreen** into screen property.
    func addToStack(screen: any NavigationScreen)
    /// - **removeLastFromStack**: method uses to remove last **NavigationScreen** from screen property.
    func removeLastFromStack()
    /// - **removeTillFromStack**: method uses to remove last n **NavigationScreen** from screen property before condition met.
    func removeTillFromStack(screen: any NavigationScreen)
    /// - **rebuildNavStack**: method uses to replace all **NavigationScreen** from screen property with new ones.
    func rebuildNavStack(with screens: [any NavigationScreen])
    
    // MARK: UINavigationController properties and methods
    
    /// - **topViewController**: (UINavigationController compatibility) The top view controller on the stack.
    var topViewController: UIViewController? { get }
    /// - **viewControllers**: (UINavigationController compatibility) The current view controller stack.
    var viewControllers: [UIViewController] { get set }
    
    /// - **pushViewController(viewController:, animated:)**: (UINavigationController compatibility) Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    /// - **popViewController(animated:)**: (UINavigationController compatibility) Returns the popped controller.
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    /// - **popToViewController(viewController:, animated:)**: (UINavigationController compatibility) Pops view controllers until the one specified is on top. Returns the popped controllers.
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    /// - **present(viewControllerToPresent:, animated:, completion:)**: (UINavigationController compatibility) Presents a view controller modally..
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    /// - **dismiss(animated:, completion:)**:(UINavigationController compatibility)  Dismisses the view controller that was presented modally by the view controller.
    func dismiss(animated flag: Bool, completion: (() -> Void)?)    
    /// - **setViewControllers(viewController:, animated:)**:(UINavigationController compatibility) If animated is YES, then simulate a push or pop depending on whether the new top view controller was previously in the stack.
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}
