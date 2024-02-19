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
        case modal
    }
    
    private let module: Module
    private let presentationStyle: PresentationStyle
    
    init(module: Module, presentationStyle: PresentationStyle) {
        self.module = module
        self.presentationStyle = presentationStyle
    }
    
    public func perform(on coordinator: Coordinator) {
        let screen = self.module.assembly(using: coordinator)
        switch self.presentationStyle {
        case .fullScreen:
            coordinator.navigationController.pushViewController(screen, animated: true)
        case .modal:
            coordinator.navigationController.present(screen, animated: true, completion: nil)
        }
    }
}

public extension NavigationAction where Self == PushNavigationAction {
    static func push(_ module: Module, as presentationStyle: Self.PresentationStyle) -> Self {
        return .init(module: module, presentationStyle: presentationStyle)
    }
}
