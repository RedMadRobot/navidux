public final class NavigationCoordinator: Coordinator {
    var navigationController: NavigationController
    var screenFactory: ScreenFactory
    var alertFactory: AlertFactory
    public var state: NavigationStore
    
    public required init(
        _ controller: NavigationController,
        screenFactory: ScreenFactory,
        alertFactory: AlertFactory = AlertFactory(),
        state: NavigationStore = NavigationStore()
    ) {
        navigationController = controller
        self.screenFactory = screenFactory
        self.alertFactory = alertFactory
        self.state = state
    }
    
    public func start() {
        actionReducer(action: .start(ScreenConfig(navigationTitle: "Start Screen", isNeedSetBackButton: false)))
    }
}
