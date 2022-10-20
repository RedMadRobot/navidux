extension NavigationCoordinator {
    public func actionReducer(action: Navigation.Action) {
        switch action {
        case let .start(config):
            let controller = screenAssembler.assemblyScreen(
                screenType: .firstScreen,
                config: config
            )
            pushNew(screen: controller, style: .fullscreen, animated: false)
            
        case let .push(screen, config, presentationStyle):
            var controller: any NavigationScreen
            controller = screenAssembler.assemblyScreen(screenType: screen, config: config)
            pushNew(screen: controller, style: presentationStyle, animated: true)
            
        case let .pop(payload):
            popLast(animated: true)
            if let topScreen = navigationController.topScreen {
                topScreen.gotUpdatedData(payload)
            }
            
        case let .popUntil(screen, payload):
            let certainController = findCertain(controller: screen, in: navigationController.screens)
            if let vc = certainController {
                popTo(screen: vc, animated: true)
                if let topScreen = navigationController.topScreen {
                    topScreen.gotUpdatedData(payload)
                }
            }
            
        case let .restruct(screens):
            let controllers: [any NavigationScreen] = screens.map {
                screenAssembler.assemblyScreen(screenType: $0.0, config: $0.1)
            }
            restruct(with: controllers, animated: true)
            
        case let .showAlert(configuration):
            let assembledAlert = screenAssembler.assemblyAlert(configuration: configuration)
            showAlert(alert: assembledAlert)
        }
    }
    
    private func findCertain(
        controller: Navigation.Screen,
        in stack: [any NavigationScreen]
    ) -> (any NavigationScreen)? {
        return stack.last(where: { [controller] in
            $0.isKind(of: controller.asScreenClass)
        })
    }
}
