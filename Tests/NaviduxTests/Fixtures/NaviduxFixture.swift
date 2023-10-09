@testable import Navidux

struct NaviduxFixture {
    static let oneScreenTag = "MockNavigationScreen"
    static let mockScreenTag = "Dummy"
    
    static func mockNavigationScreen(
        coordinator: Router? = nil,
        tag: String = NaviduxFixture.mockScreenTag,
        output: ((NullablePayload) -> Void)? = nil
    ) -> any NavigationScreen {
        return ViewController(
            navigation: coordinator,
            tag: tag,
            output: output ?? { _ in }
        )
    }
    
    static func mockScreenConfig() -> ScreenConfig {
        ScreenConfig(
            navigationTitle: "Default Mock",
            output: { payload in
                print("OUTPUT_PAYLOAD: \(String(describing: payload))")
            }
        )
    }
}

struct ScreenFactoryFixture: ScreenFactory {
    var mockNavigationScreen: any NavigationScreen
    
    var findPersonScreenFactory: (Router, ScreenConfig) -> any NavigationScreen {
        { _, _ in
            mockNavigationScreen
        }
    }
    
    var employeePersonalInfoScreenFactory: (Router, ScreenConfig) -> any NavigationScreen {
        { _, _ in
            mockNavigationScreen
        }
    }
}
