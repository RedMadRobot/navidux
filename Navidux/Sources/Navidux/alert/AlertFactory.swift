import UIKit

public protocol AlertFactory {
    func createAlert(configuration : AlertConfiguration) -> AlertScreen
}

public final class AlertFactoryImpl: AlertFactory {
    public func createAlert(configuration : AlertConfiguration) -> AlertScreen {
        AlertScreen(configuration: configuration)
    }

    public init() {}
}
