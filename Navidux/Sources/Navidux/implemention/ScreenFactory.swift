import Foundation

// (Dependencies) -> (Configuration) -> Resulted VC
public protocol ScreenFactory {
    //TODO: Убрать зависимость от конкретного модуля
    var findPersonScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen { get }
    var employeePersonalInfoScreenFactory: (Coordinator, ScreenConfig) -> any NavigationScreen { get }
}
