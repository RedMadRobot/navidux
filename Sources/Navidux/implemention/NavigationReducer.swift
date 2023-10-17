extension NavigationCoordinator {
    
    // MARK: - Public methods
    
    public func route(with action: Navigation.Action) {
        switch action {
        case let .push(screen, config, presentationStyle):
            var controller: any NavigationScreen
            controller = screenAssembler.assemblyScreen(
                components: ScreenAsseblyComponents(
                    screenType: screen,
                    config: config
                )
            )
            pushNew(screen: controller, style: presentationStyle, animated: true)
            
        case let .pop(payload):
            guard navigationController.screens.count != 1 else {
                navigationController.topScreen?.dismiss(animated: true, completion: nil)
                print("Navigation Coordinator can't pop last screen")
                return
            }
            popLast(animated: true)
            if let topScreen = navigationController.topScreen {
                topScreen.gotUpdatedData(payload)
                topScreen.output(payload)
            }
            
        case let .popUntil(screen, payload):
            let certainController = findCertain(controller: screen, in: navigationController.screens)
            if let vc = certainController {
                popTo(screen: vc, animated: true)
                if let topScreen = navigationController.topScreen {
                    topScreen.gotUpdatedData(payload)
                    topScreen.output(payload)
                }
            }
        
        case let .restruct(screens, animationType):
            let controllers: [any NavigationScreen] = screens.compactMap { screen in
                switch screen {
                case let components as ScreenAsseblyComponents:
                    return screenAssembler.assemblyScreen(components: components)
                case let navigationScreen as any NavigationScreen:
                    return navigationScreen
                default:
                    return nil
                }
            }
            restruct(with: controllers, animated: true, animationType: animationType)
            
        case let .replaceCertain(screen, config, animationType):
            var controllers = navigationController.viewControllers.compactMap { $0 as? any NavigationScreen }
            let newController = screenAssembler.assemblyScreen(
                components: ScreenAsseblyComponents(
                    screenType: screen,
                    config: config
                )
            )
            if controllers.last != nil {
                controllers[controllers.count - 1] = newController
            } else {
                controllers = [newController]
            }
            restruct(with: controllers, animated: true, animationType: animationType)
            
        case let .showAlert(configuration):
            let assembledAlert = screenAssembler.assemblyAlert(configuration: configuration)
            showAlert(alert: assembledAlert)
        }
    }

    public func findCertain(controller: NaviduxScreen) -> (any NavigationScreen)? {
        findCertain(controller: controller, in: navigationController.screens)
    }
    
    public func findFirstCertain(controller: NaviduxScreen) -> (any NavigationScreen)? {
        findFirstCertain(controller: controller, in: navigationController.screens)
    }

    // MARK: - Private methods
    
    private func findCertain(
        controller: NaviduxScreen,
        in stack: [any NavigationScreen]
    ) -> (any NavigationScreen)? {
        return stack.last(where: { [controller] in
            $0.isKind(of: controller.asScreenClass)
        })
    }
    
    private func findFirstCertain(
        controller: NaviduxScreen,
        in stack: [any NavigationScreen]
    ) -> (any NavigationScreen)? {
        return stack.first(where: { [controller] in
            $0.isKind(of: controller.asScreenClass)
        })
    }
}
