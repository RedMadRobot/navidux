///Proxy give possibility to create `ScreenAssembler` that nessasary for `NavigationCoordinator`.
///Usage: after declaration `NavigationCoordinatorProxy` you can create `ScreenAssembler`.
///Next step to create real `Router`. And last stage is set subject property as real `Router`.
/// - Example:
///``` swift
///let navigationController = NavigationControllerImpl()
///let screenFactory = NaviduxScreenFactory()
///let alertFactory = AlertFactoryImpl()
///let navigationCoordinatorProxy = NavigationCoordinatorProxy()
///let screenAssembler = NaviduxScreenAssembler(
///    screenFactory: screenFactory,
///    alertFactory: alertFactory,
///    screenCoordinator: navigationCoordinatorProxy
///)
///
///let navigationCoordinator = NavigationCoordinator(
///    navigationController,
///    screenAssembler: screenAssembler
///)
///navigationCoordinatorProxy.subject = navigationCoordinator
///```
public final class NavigationCoordinatorProxy: Router {
    public var subject: NavigationCoordinator!

    public init(subject: NavigationCoordinator? = nil) {
        self.subject = subject
    }

    public func route(with action: Navigation.Action) {
        subject.route(with: action)
    }
    
    public func findCertain(controller: NaviduxScreen) -> (any NavigationScreen)? {
        subject.findCertain(controller: controller)
    }
    
    public func findFirstCertain(controller: NaviduxScreen) -> (any NavigationScreen)? {
        subject.findFirstCertain(controller: controller)
    }
}
