import UIKit

public final class AlertScreen {
    let configuration: AlertConfiguration
    
    init(configuration: AlertConfiguration) {
        self.configuration = configuration
    }
    
    func generateAlert(dismissedCallback: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(
            title: configuration.title,
            message: configuration.message,
            preferredStyle: configuration.style == .center ? .alert : .actionSheet
        )
        configuration.actions.map { config in
            UIAlertAction(
                title: config.title,
                style: config.style.asUIAlertActionStyle,
                handler: { _ in
                    dismissedCallback()
                    config.action()
                }
            )
        }.forEach { alert.addAction($0) }
        return alert
    }
}
