import Navidux

extension Navidux.ScreenFactory {
    var firstScreenFactory: (NavigationCoordinator?, ScreenConfig) -> any NavigationScreen {
        { coordinator, screenConfig in
            let viewContent = FirstContentView(navigation: coordinator)
            let viewController = HostingController(
                title: screenConfig.navigationTitle,
                isNeedBackButton: false,
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
                title: screenConfig.navigationTitle,
                isNeedBackButton: true,
                tag: "SecondContentView",
                navigation: coordinator,
                content: viewContent
            )
            
            return viewController
        }
    }
    
    var thirdScreenFactory: (NavigationCoordinator?, ScreenConfig) -> any NavigationScreen {
        { coordinator, screenConfig in
            ThirdContentViewController()
        }
    }
}

final class NaviduxScreenFactory: Navidux.ScreenFactory {
    init() {}
}
