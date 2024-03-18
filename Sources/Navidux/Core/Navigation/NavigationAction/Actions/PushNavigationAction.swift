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
    private let animated: Bool
    private let completion: (() -> Void)?
    
    init(module: Module, presentationStyle: PresentationStyle, animated: Bool, completion: (() -> Void)?) {
        self.module = module
        self.presentationStyle = presentationStyle
        self.animated = animated
        self.completion = completion
    }
    
    public func perform(on coordinator: Coordinator) {
        let screen = self.module.assembly(using: coordinator)
        
        switch self.presentationStyle {
        case .fullScreen:
            coordinator.navigationController.push(screen: screen, animated: self.animated, isModal: false, completion: self.completion)
        case .modal:
            coordinator.navigationController.push(screen: screen, animated: self.animated, isModal: true, completion: self.completion)
        }
    }
}

public extension NavigationAction where Self == PushNavigationAction {
    static func push(_ module: Module, as presentationStyle: Self.PresentationStyle = .fullScreen, animated: Bool = true, completion: (() -> Void)?) -> Self {
        return PushNavigationAction(module: module, presentationStyle: presentationStyle, animated: animated, completion: completion)
    }
}
