import UIKit

extension NavigationCoordinator {
    func assemblyScreen(screenType: Navigation.Screen, config: ScreenConfig) -> any NavigationScreen {
        switch screenType {
        case .firstScreen:
            return screenFactory.findPersonScreenFactory(self, config)
        case .secondScreen:
            return screenFactory.findPersonScreenFactory(self, config)
        }
    }
    
    func asemblyAlert(configuration: AlertConfiguration) -> AlertScreen {
        alertFactory.createAlert(configuration: configuration)
    }
}
