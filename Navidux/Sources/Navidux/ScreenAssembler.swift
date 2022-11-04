public protocol ScreenAssembler {
    func assemblyScreen(screenType: Navigation.Screen, config: ScreenConfig) -> any NavigationScreen
    func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen
}
