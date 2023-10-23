import UIKit

public final class NavigationControllerImpl: UINavigationController, NavigationController {
   
    // MARK: - Private properties
    
    private var navbarConfiguration: (UINavigationController) -> Void = { controller in
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
    
    // MARK: - Public properties
    
    public var screens: [any NavigationScreen] = [] {
        didSet { debugPrint("screenStack: \(screens.map { $0.tag })") }
    }
    
    public var topScreen: (any NavigationScreen)? {
        screens.last
    }
    
    // MARK: - Init
    
    public init(
        navbarConfiguration: ((UINavigationController) -> Void)? = nil
    ) {
        if let navbarConfiguration {
            self.navbarConfiguration = navbarConfiguration
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated, message: "use init() instead.")
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    // MARK: - Public methods
    
    public func addToStack(screen: any NavigationScreen) {
        screens.append(screen)
    }
    
    public func removeLastFromStack() {
        guard screens.count != 1 else {
            print("Navigation Coordinator can't pop last screen")
            return
        }
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

    public override var childForStatusBarStyle: UIViewController? {
        self.topViewController
    }
    
    // MARK: - Private methods
    
    public func configureAppearance() {
        navbarConfiguration(self)
    }
}
