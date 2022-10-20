//
//  NavigationController.swift
//  NaviduxTests
//
//  Created by Александр Евсеев on 12.10.2022.
//  Copyright © 2022 red_mad_robot. All rights reserved.
//

import UIKit

/// NavigationController its abstract object uses for navigation. Its a closest wrapper to UINavigation controller or alternative.
/// - parameters:
/// - **screens**: return some representation of screen from UINavigationController.viewController. Difference in track screen in navigation stack.
/// - **topScreen**: return screen from top of the
/// - **addToStack**: method uses to add **NavigationScreen** into screen property.
/// - **removeLastFromStack**: method uses to remove last **NavigationScreen** from screen property.
/// - **removeTillFromStack**: method uses to remove last n **NavigationScreen** from screen property before condition met.
/// - **rebuildNavStack**: method uses to replace all **NavigationScreen** from screen property with new ones.
/// - parameters:
/// - **topViewController**: (UINavigationController compatibility) The top view controller on the stack.
/// - **viewControllers**: (UINavigationController compatibility) The current view controller stack.
/// - **pushViewController(viewController:, animated:)**: (UINavigationController compatibility) Uses a horizontal slide transition. Has no effect if the view controller is already in the stack.
/// - **popViewController(animated:)**: (UINavigationController compatibility) Returns the popped controller.
/// - **popToViewController(viewController:, animated:)**: (UINavigationController compatibility) Pops view controllers until the one specified is on top. Returns the popped controllers.
/// - **present(viewControllerToPresent:, animated:, completion:)**: (UINavigationController compatibility) Presents a view controller modally..
/// - **dismiss(animated:, completion:)**:(UINavigationController compatibility)  Dismisses the view controller that was presented modally by the view controller..
public protocol NavigationController {
    var screens: [any NavigationScreen] { get set }
    var topScreen: (any NavigationScreen)? { get }
    
    func addToStack(screen: any NavigationScreen)
    func removeLastFromStack()
    func removeTillFromStack(screen: any NavigationScreen)
    func rebuildNavStack(with screens: [any NavigationScreen])
    
    // MARK: UINavigationController properties and methods
    
    var topViewController: UIViewController? { get }
    var viewControllers: [UIViewController] { get set }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    @discardableResult
    func popViewController(animated: Bool) -> UIViewController?
    @discardableResult
    func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]?
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}
