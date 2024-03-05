//
//  PushNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import Foundation

public struct PushNavigationAction: NavigationAction {
    public enum PresentationStyle {
        case fullScreen
        case modal(completion: (() -> Void)?)
        case bottomSheet(BSSize, completion: (() -> Void)?)
    }
    
    private let module: Module
    private let presentationStyle: PresentationStyle
    private let animated: Bool
    
    init(module: Module, presentationStyle: PresentationStyle, animated: Bool) {
        self.module = module
        self.presentationStyle = presentationStyle
        self.animated = animated
    }
    
    public func perform(on coordinator: Coordinator) {
        let screen = self.module.assembly(using: coordinator)
        switch self.presentationStyle {
        case .fullScreen:
            coordinator.navigationController.pushViewController(screen, animated: self.animated)
        case .modal(let completion):
            coordinator.store.hasOverlay = true
            coordinator.navigationController.present(screen, animated: self.animated, completion: completion)
        case .bottomSheet(let size, let completion):
            BSBuilder.buildBottomSheet(
                coordinator: coordinator,
                screen: screen,
                size: size
            )
            coordinator.navigationController.present(screen, animated: self.animated, completion: completion)
        }
    }
}

public extension NavigationAction where Self == PushNavigationAction {
    static func push(_ module: Module, as presentationStyle: Self.PresentationStyle = .fullScreen, animated: Bool = true) -> Self {
        PushNavigationAction(module: module, presentationStyle: presentationStyle, animated: animated)
    }
}
