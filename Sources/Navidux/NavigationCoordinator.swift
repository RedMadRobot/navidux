public final class NavigationCoordinator: Router {
    var navigationController: NavigationController
    var screenAssembler: ScreenAssembler
    public var state: NavigationStore
    let bottomSheetTransitioningDelegate = BSTransitioningDelegate()

    public init(
        _ controller: NavigationController,
        screenAssembler: some ScreenAssembler,
        state: NavigationStore = NavigationStore()
    ) {
        navigationController = controller
        self.screenAssembler = screenAssembler
        self.state = state
    }
}
