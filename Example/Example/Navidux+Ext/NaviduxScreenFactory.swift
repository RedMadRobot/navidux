import Navidux

extension Navidux.ScreenFactory {
    var firstScreenFactory: (NavigationCoordinator?, ScreenConfig) -> any NavigationScreen {
        { coordinator, screenConfig in
            let viewContent = FirstContentView(navigation: coordinator)
            let viewController = HostingController(
                navTitle: screenConfig.navigationTitle,
                tag: "FirstContentView",
                navigation: coordinator,
                content: viewContent
            )

            return viewController
        }
    }
    
    var secondScreenFactory: (NavigationCoordinator?, ScreenConfig) -> any NavigationScreen {
        { coordinator, screenConfig in
            let viewContent = SecondContentView(navigation: coordinator)
            let viewController = HostingController(
                navTitle: screenConfig.navigationTitle,
                setBackButton: true,
                tag: "SecondContentView",
                navigation: coordinator,
                content: viewContent
            )

            return viewController
        }
    }
}

final class NaviduxScreenFactory: Navidux.ScreenFactory {
    init() {}
}
