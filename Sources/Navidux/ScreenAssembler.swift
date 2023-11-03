import Foundation
import SafariServices

public protocol ScreenAssembler {
    func assemblyScreen(components: ScreenAsseblyComponents) -> any NavigationScreen
    func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen
    func assemblySFSafaryViewController(url: URL, delegate: SFSafariViewControllerDelegate?) -> SFSafariViewController
}

extension ScreenAssembler {
    public func assemblySFSafaryViewController(url: URL, delegate: SFSafariViewControllerDelegate?) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = delegate
        return controller
    }
}

public struct ScreenAsseblyComponents: NavigationRestructable {
    public let screenType: NaviduxScreen
    public let config: ScreenConfig
    
    public init(screenType: NaviduxScreen, config: ScreenConfig) {
        self.screenType = screenType
        self.config = config
    }
}
