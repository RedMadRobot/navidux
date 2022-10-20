import UIKit

extension NavigationCoordinator {
    func pushNew(screen: any NavigationScreen, style: Navigation.PresentationStyle, animated: Bool) {
        switch style {
        case .fullscreen:
            screen.navigationCallback = { [weak self] in
                self?.controllerDismissed(screenTag: screen.tag)
            }
            navigationController.pushViewController(screen, animated: animated)
        case .modal:
            screen.isModal = true
            screen.navigationCallback = { [weak self, weak screen] in
                self?.modalControllerDismissed(screenTag: screen?.tag)
            }
            state.hasOverlay = true
            navigationController.present(screen, animated: animated, completion: nil)
        // TODO: [JBNFS-26] Подготовить контейнер с боттом щитом
        case let .bottomSheet(sizes):
            screen.isModal = true
            let sheetController = screen
            sheetController.navigationCallback = { [weak self, weak screen] in
                self?.modalControllerDismissed(screenTag: screen?.tag)
            }
            state.hasOverlay = true
            navigationController.present(sheetController, animated: false, completion: nil)
        // TODO: [JBNFS-47] Добавить кастомный режим показа экрана
        case let .custom(delegate):
            break
        }
        navigationController.addToStack(screen: screen)
    }
    
    func showAlert(alert: AlertScreen) {
        guard !state.isAlertShow else { return }
        state.isAlertShow = true
        navigationController.present(
            alert.generateAlert(dismissedCallback: { [weak self] in
                self?.alertControllerDismissed()
            }),
            animated: true,
            completion: nil
        )
    }
    
    func popLast(animated: Bool) {
        if state.hasOverlay {
            state.hasOverlay = false
            navigationController.dismiss(animated: animated, completion: nil)
        } else {
            navigationController.popViewController(animated: animated)
        }
        
        navigationController.removeLastFromStack()
    }
    
    func popTo(screen: any NavigationScreen, animated: Bool) {
        if state.hasOverlay {
            state.hasOverlay = false
            navigationController.dismiss(animated: animated, completion: nil)
        }
        navigationController.popToViewController(screen, animated: animated)
        navigationController.removeTillFromStack(screen: screen)
    }
    
    // TODO: [JBNFS-48] Доработать, чтобы можно было брать старые экраны из созданных, а не создавать с нуля
    func restruct(with screens: [any NavigationScreen], animated: Bool) {
        if navigationController.topViewController == screens.last {
            // Если верхний экран равен верхнему экрану из нового стэка, то просто переставляем все экраны
            navigationController.viewControllers = screens
        } else {
            // Если верхний экране не равен, то обновляем все экраны, при этом оставляем верхний на месте, и после обновлния попаем(дисмиссим) его.
            var newStack = (screens.map { $0 as UIViewController })
            if !state.hasOverlay {
                newStack += [navigationController.topViewController].compactMap { $0 }
            }
            navigationController.viewControllers = newStack
            
            if navigationController.topScreen?.isModal ?? false {
                state.hasOverlay = false
                navigationController.dismiss(animated: animated, completion: nil)
            } else {
                navigationController.popViewController(animated: animated)
            }
        }
        navigationController.rebuildNavStack(with: screens)
    }
    
    private func checkEquality(lhs: [any NavigationScreen], rhs: [any NavigationScreen]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        
        var result: Bool = true
        
        for (leftElement, rightElement) in zip(lhs, rhs) {
            if leftElement.tag != rightElement.tag {
                result = false
                break
            }
        }
        
        return result
    }
    
    // Колбэк, который вызывается с верхнего экрана-модалки, который закрыли (и программно и жестом)
    private func modalControllerDismissed(screenTag: String?) {
        guard let screenTag = screenTag else { return }
        
        let topScreen = navigationController.topScreen
        if state.hasOverlay && topScreen?.isModal ?? false && topScreen?.tag == screenTag {
            navigationController.removeLastFromStack()
            state.hasOverlay = false
        }
    }
    
    private func alertControllerDismissed() {
        state.isAlertShow = false
    }
    
    // Колбэк, который вызывается с верхнего экрана, который закрыли (и программно и жестом)
    private func controllerDismissed(screenTag: String?) {
        guard let screenTag = screenTag else { return }
        
        let topScreen = navigationController.topScreen
        if !(topScreen?.isModal ?? true) && topScreen?.tag == screenTag {
            navigationController.removeLastFromStack()
        }
    }
}
