import UIKit

public final class BaseNavigationController: UINavigationController, NavigationController {
    private(set) public var stack: [any NavigationScreen] = .init()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure { controller in
            controller.view.backgroundColor = .white
            controller.navigationBar.isTranslucent = false
            controller.navigationBar.backgroundColor = .white
            controller.navigationBar.shadowImage = .init()
            controller.navigationBar.barTintColor = .white
            controller.navigationBar.tintColor = .black
            controller.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
    }
    
    public func set(stack: [any NavigationScreen]) {
        self.stack = stack
        self.setViewControllers(stack, animated: true)
    }
    
    public func push(screen: any NavigationScreen, animated: Bool, isModal: Bool, completion: (() -> Void)?) {
        self.stack.insert(screen, at: 0)
        
        if isModal {
            self.present(screen, animated: animated, completion: completion)
        } else {
            self.pushViewController(screen, animated: animated, completion: completion)
        }
    }
    
    @discardableResult
    public func pop(animated: Bool, completion: (() -> Void)?) -> any NavigationScreen {
        let screen = self.stack.removeFirst()
        
        if let presentingViewController = self.presentingViewController {
            presentingViewController.dismiss(animated: animated)
            return screen
        }
        
        self.popViewController(animated: animated, completion: completion)
        
        return screen
    }
    
    @discardableResult
    public func popTo<T: NavigationScreen>(_ screenType: T.Type, animated: Bool, completion: (() -> Void)?) -> [any NavigationScreen]? {
        guard let screen = self.stack.first(where: { $0 is T }) else { return nil }
        return self.popTo(screen: screen, animated: animated, completion: completion)
    }
    
    @discardableResult
    public func popTo<T: NavigationScreen>(screen: T, animated: Bool, completion: (() -> Void)?) -> [any NavigationScreen]? {
        guard let vc = self.stack.first(where: { $0 == screen }) else { return nil }
        
        var poppedScreens: [any NavigationScreen] = []
        
        for item in self.stack {
            if let topScreen = self.stack.first, topScreen == item {
                break
            }
            
            poppedScreens.append(self.stack.removeFirst())
        }
        
        self.popToViewController(vc, animated: animated, completion: completion)
        
        return poppedScreens
    }
    
    public func configure(_ configurator: (UINavigationController) -> Void) {
        configurator(self)
    }
}
