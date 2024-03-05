//
//  BSBuilder.swift
//
//
//  Created by Петр Тартынских on 05.03.2024.
//

import Foundation

class BSBuilder {
    
    static func buildBottomSheet(
        coordinator: Coordinator,
        screen: any NavigationScreen,
        size: BSSize
    ) {
        switch size {
        case .auto:
            coordinator.bottomSheetTransitioningDelegate.sheetSize = .auto
            screen.transitioningDelegate = coordinator.bottomSheetTransitioningDelegate
            screen.modalPresentationStyle = .custom
        case .fixed(let height):
            coordinator.bottomSheetTransitioningDelegate.sheetSize = .fixed(height)
            screen.transitioningDelegate = coordinator.bottomSheetTransitioningDelegate
            screen.modalPresentationStyle = .custom
        case .halfScreen:
            coordinator.bottomSheetTransitioningDelegate.sheetSize = .halfScreen
            screen.transitioningDelegate = coordinator.bottomSheetTransitioningDelegate
            screen.modalPresentationStyle = .custom
        case .fullScreen:
            screen.modalPresentationStyle = .formSheet
        }
        coordinator.store.hasOverlay = true
    }
}
