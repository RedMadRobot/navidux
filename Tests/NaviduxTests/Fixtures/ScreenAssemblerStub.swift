@testable import Navidux

enum ScreenAssemblerStubAction: Equatable {
    case assembleScreen(Navidux.NaviduxScreen)
    case assembleAlert(Navidux.AlertConfiguration)
}

final class ScreenAssemblerStub: ScreenAssembler {
    var actions = [ScreenAssemblerStubAction]()
    var navigation: Router?
    var vcTag: String?
    var screenToPush: (any Navidux.NavigationScreen)?

    init(navigation: Router? = nil, vcTag: String? = nil, screenToPush: (any Navidux.NavigationScreen)? = nil) {
        self.navigation = navigation
        self.vcTag = vcTag
        self.screenToPush = screenToPush
    }

    func assemblyScreen(components: Navidux.ScreenAsseblyComponents) -> any Navidux.NavigationScreen {
        screenToPush ?? NaviduxFixture.mockNavigationScreen(
            coordinator: navigation,
            tag: vcTag ?? "",
            output: components.config.output
        )
    }

    func assemblyAlert(configuration: Navidux.AlertConfiguration) -> Navidux.AlertScreen {
        AlertScreen(configuration: configuration)
    }
}
