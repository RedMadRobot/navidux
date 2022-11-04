///Proxy give possibility to create `ScreenAssembler` that nessasary for `NavigationCoordinator`.
///Usage: after declaration `NavigationCoordinatorProxy` you can create `ScreenAssembler`.
///Next step to create real `Coordinator`. And last stage is set subject property as real `Coordinator`.
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
public final class NavigationCoordinatorProxy: Coordinator {
    public var subject: Coordinator!

    public init(subject: Coordinator? = nil) {
        self.subject = subject
    }

    public func actionReducer(action: Navigation.Action) {
        subject.actionReducer(action: action)
    }
}
