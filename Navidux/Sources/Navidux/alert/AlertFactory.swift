import UIKit

public final class AlertFactory {
    func createAlert(configuration : AlertConfiguration) -> AlertScreen {
        AlertScreen(configuration: configuration)
    }
    
    public init() {}
}
