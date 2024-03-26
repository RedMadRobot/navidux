import UIKit

public protocol NavigationController {
    var stack: [any NavigationScreen] { get }
    
    func set(stack: [any NavigationScreen])
    
    func push(screen: any NavigationScreen, animated: Bool, completion: (() -> Void)?)
    
    @discardableResult
    func pop(animated: Bool, completion: (() -> Void)?) -> any NavigationScreen
    
    @discardableResult
    func popTo<T: NavigationScreen>(_ screenType: T.Type, animated: Bool, completion: (() -> Void)?) -> [any NavigationScreen]?
    
    @discardableResult
    func popTo<T: NavigationScreen>(screen: T, animated: Bool, completion: (() -> Void)?) -> [any NavigationScreen]?
}
