public protocol ScreenAssembler {
    func assemblyScreen(screenType: NaviduxScreen, config: ScreenConfig) -> any NavigationScreen
    func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen
}
