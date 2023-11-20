import UIKit
import SafariServices

extension NavigationCoordinator {
    
    // MARK: - Public methods
    
    func pushNew(screen: any NavigationScreen, style: Navigation.PresentationStyle, animated: Bool) {
        switch style {
        case .fullscreen:
            screen.navigationCallback = { [weak self, weak screen] in
                self?.controllerDismissed(screenTag: screen?.tag)
            }
            navigationController.pushViewController(screen, animated: animated)
            
        case .modal:
            screen.isModal = true
            screen.navigationCallback = { [weak self, weak screen] in
                self?.modalControllerDismissed(screenTag: screen?.tag)
            }
            if state.hasOverlay {
                navigationController.topScreen?.present(screen, animated: animated, completion: nil)
            } else {
                navigationController.present(screen, animated: animated, completion: nil)
            }
            state.hasOverlay = true
            
        // TODO: - Допилить SheetViewController
        case let .bottomSheet(size):
            screen.isModal = true
            screen.navigationCallback = { [weak self, weak screen] in
                self?.modalControllerDismissed(screenTag: screen?.tag)
            }
            state.hasOverlay = true
            
            switch size {
            case .auto:
                bottomSheetTransitioningDelegate.sheetSize = .auto
                screen.transitioningDelegate = bottomSheetTransitioningDelegate
                screen.modalPresentationStyle = .custom
            case .fixed(let height):
                bottomSheetTransitioningDelegate.sheetSize = .fixed(height)
                screen.transitioningDelegate = bottomSheetTransitioningDelegate
                screen.modalPresentationStyle = .custom
            case .halfScreen:
                bottomSheetTransitioningDelegate.sheetSize = .halfScreen
                screen.transitioningDelegate = bottomSheetTransitioningDelegate
                screen.modalPresentationStyle = .custom
            case .fullScreen:
                screen.modalPresentationStyle = .formSheet
            }
            
            navigationController.present(screen, animated: true, completion: nil)
            
        // TODO: - Реализовать
        case let .custom(delegate):
            break
        }
        navigationController.addToStack(screen: screen)
    }
    
    func showAlert(alert: AlertScreen) {
        guard !state.isAlertShow else { return }
        state.isAlertShow = true
        navigationController.present(
            alert.generateAlert(
                dismissedCallback: { [weak self] in
                    self?.alertControllerDismissed()
                }
            ),
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
    
    func restruct(
        with screens: [any NavigationScreen],
        animated: Bool,
        animationType: Navigation.RestructActionAnimation
    ) {
        guard navigationController.topViewController != screens.last else {
            navigationController.viewControllers = screens
            return
        }
        
        switch animationType {
        case .forward:
            updateStackWithForwardAnimation(
                screens: screens,
                navigationController: &navigationController,
                store: &state,
                animated: animated
            )
        case .backward:
            updateStackWithBackwardAnimation(
                screens: screens,
                navigationController: &navigationController,
                store: &state,
                animated: animated
            )
        }

        navigationController.rebuildNavStack(with: screens)
    }
    
    func presentSFSafaryViewController(_ controller: SFSafariViewController, animated: Bool) {
        if state.hasOverlay {
            navigationController.topScreen?.present(controller, animated: animated, completion: nil)
        } else {
            navigationController.present(controller, animated: animated, completion: nil)
        }
        state.hasOverlay = true
    }
    
    // MARK: - Private methods
    
    private func updateStackWithBackwardAnimation(
        screens: [any NavigationScreen],
        navigationController: inout NavigationController,
        store: inout NavigationStore,
        animated: Bool
    ) {
        var newStack = (screens.map { $0 as UIViewController })
        if !store.hasOverlay {
            newStack += [navigationController.topViewController].compactMap { $0 }
        }
        navigationController.viewControllers = newStack

        if navigationController.topScreen?.isModal ?? false {
            store.hasOverlay = false
            navigationController.dismiss(animated: animated, completion: nil)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }

    private func updateStackWithForwardAnimation(
        screens: [any NavigationScreen],
        navigationController: inout NavigationController,
        store: inout NavigationStore,
        animated: Bool
    ) {
        let newStack = screens.map { $0 as UIViewController }
        navigationController.setViewControllers(newStack, animated: animated)
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
    
    private func modalControllerDismissed(screenTag: String?) {
        guard let screenTag = screenTag else { return }

        let topScreen = navigationController.topScreen
        if state.hasOverlay,
           topScreen?.isModal ?? false,
           topScreen?.tag == screenTag {
            navigationController.removeLastFromStack()
            if !(navigationController.topScreen?.isModal ?? false) {
                state.hasOverlay = false
            }
            navigationController.topScreen?.gotUpdatedData(topScreen?.dataToSendFromModal)
        }
    }
    
    private func alertControllerDismissed() {
        state.isAlertShow = false
    }
    
    private func controllerDismissed(screenTag: String?) {
        guard let screenTag = screenTag else { return }
        
        let topScreen = navigationController.topScreen
        if !(topScreen?.isModal ?? true) && topScreen?.tag == screenTag {
            navigationController.removeLastFromStack()
        }
    }
}
