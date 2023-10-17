import Navidux

public final class NaviduxScreenAssembler: Navidux.ScreenAssembler {
    private var screenFactory: any Navidux.ScreenFactory
    private var alertFactory: Navidux.AlertFactory
    private var screenCoordinator: Navidux.NavigationCoordinatorProxy?

    public init(
        screenFactory: Navidux.ScreenFactory,
        alertFactory: Navidux.AlertFactory,
        screenCoordinator: Navidux.NavigationCoordinatorProxy?
    ) {
        self.screenFactory = screenFactory
        self.alertFactory = alertFactory
        self.screenCoordinator = screenCoordinator
    }
    
    public func assemblyScreen(screenType: NaviduxScreen, config: ScreenConfig) -> any NavigationScreen {
        switch screenType {
        case .firstScreen:
            return screenFactory.firstScreenFactory(screenCoordinator?.subject, config)
        case .secondScreen:
            return screenFactory.secondScreenFactory(screenCoordinator?.subject, config)
        default:
            return ViewController(navigation: nil)
        }
    }

    public func assemblyScreen(components: ScreenAsseblyComponents) -> any NavigationScreen {
        assemblyScreen(screenType: components.screenType, config: components.config)
    }
    
    public func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen {
        alertFactory.createAlert(configuration: configuration)
    }
}
