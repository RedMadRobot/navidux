@testable import Navidux

struct NaviduxFixture {
    static let oneScreenTag = "MockNavigationScreen"
    static let mockScreenTag = "Dummy"
    
    static func mockNavigationScreen(
        coordinator: Coordinator? = nil,
        tag: String = NaviduxFixture.mockScreenTag
    ) -> any NavigationScreen {
        return ViewController(navigation: coordinator, tag: tag)
    }
    
    static func mockScreenConfig() -> ScreenConfig {
        ScreenConfig(navigationTitle: "Default Mock")
    }
}

struct ScreenFactoryFixture: ScreenFactory {
    var mockNavigationScreen: any NavigationScreen
    
    var findPersonScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen {
        { _, _ in
            mockNavigationScreen
        }
    }
    
    var employeePersonalInfoScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen {
        { _, _ in
            mockNavigationScreen
        }
    }
}
