import Foundation

public protocol ScreenFactory {
    var findPersonScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen { get }
    var employeePersonalInfoScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen { get }
}
