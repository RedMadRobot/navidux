public final class NavigationCoordinator: Coordinator {
    var navigationController: NavigationController
    var screenAssembler: ScreenAssembler
    public var state: NavigationStore

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
