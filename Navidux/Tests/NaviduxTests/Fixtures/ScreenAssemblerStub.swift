@testable import Navidux

enum ScreenAssemblerStubAction: Equatable {
    case assembleScreen(Navidux.Navigation.Screen)
    case assembleAlert(Navidux.AlertConfiguration)
}

final class ScreenAssemblerStub: ScreenAssembler {
    var actions = [ScreenAssemblerStubAction]()
    var navigation: Coordinator?
    var vcTag: String?
    var screenToPush: (any Navidux.NavigationScreen)?

    init(navigation: Coordinator? = nil, vcTag: String? = nil, screenToPush: (any Navidux.NavigationScreen)? = nil) {
        self.navigation = navigation
        self.vcTag = vcTag
        self.screenToPush = screenToPush
    }

    func assemblyScreen(
        screenType: Navidux.Navigation.Screen,
        config: Navidux.ScreenConfig
    ) -> any Navidux.NavigationScreen {
        screenToPush ?? NaviduxFixture.mockNavigationScreen(coordinator: navigation, tag: vcTag ?? "")
    }

    func assemblyAlert(configuration: Navidux.AlertConfiguration) -> Navidux.AlertScreen {
        AlertScreen(configuration: configuration)
    }
}
