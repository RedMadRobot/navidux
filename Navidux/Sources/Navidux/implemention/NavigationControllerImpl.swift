import UIKit

public final class NavigationControllerImpl: UINavigationController, NavigationController {
    public var screens: [any NavigationScreen] = [] {
        didSet { debugPrint("screenStack: \(screens.map { $0.tag })") }
    }
    
    public var topScreen: (any NavigationScreen)? {
        screens.last
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated, message: "use init() instead.")
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func addToStack(screen: any NavigationScreen) {
        screens.append(screen)
    }
    
    public func removeLastFromStack() {
        screens.removeLast()
    }
    
    public func removeTillFromStack(screen: any NavigationScreen) {
        if let idx = screens.lastIndex(where: { $0 == screen }) {
            screens.removeLast(screens.count - (idx + 1))
        }
    }
    
    public func rebuildNavStack(with screens: [any NavigationScreen]) {
        self.screens = screens
    }
}
