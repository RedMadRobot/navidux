public protocol ScreenAssembler {
    func assemblyScreen(components: ScreenAsseblyComponents) -> any NavigationScreen
    func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen
}

public struct ScreenAsseblyComponents: NavigationRestructable {
    public let screenType: NaviduxScreen
    public let config: ScreenConfig
    
    public init(screenType: NaviduxScreen, config: ScreenConfig) {
        self.screenType = screenType
        self.config = config
    }
}
