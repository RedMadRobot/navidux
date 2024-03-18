//
//  PopNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import UIKit

public struct PopNavigationAction: NavigationAction {
    public enum ScreenKind {
        case screen(any NavigationScreen)
        case type(any NavigationScreen.Type)
    }
    
    private let screenKind: ScreenKind?
    private let animated: Bool
    private let completion: (() -> Void)?
    
    init(screenKind: ScreenKind?, animated: Bool, completion: (() -> Void)?) {
        self.screenKind = screenKind
        self.animated = animated
        self.completion = completion
    }
    
    public func perform(on coordinator: Coordinator) {
        switch self.screenKind {
        case .screen(let screen):
            coordinator.navigationController.popTo(screen: screen, animated: self.animated, completion: self.completion)
        case .type(let type):
            coordinator.navigationController.popTo(type, animated: self.animated, completion: self.completion)
        case .none:
            coordinator.navigationController.pop(animated: self.animated, completion: self.completion)
        }
    }
}

public extension NavigationAction where Self == PopNavigationAction {
    static var pop: Self {
        return PopNavigationAction(screenKind: nil, animated: true, completion: nil)
    }
    
    static func pop(animated: Bool, completion: (() -> Void)? = nil) -> Self {
        return PopNavigationAction(screenKind: nil, animated: animated, completion: completion)
    }
    
    static func popTo(_ screenType: Self.ScreenKind, animated: Bool = true, completion: (() -> Void)? = nil) -> Self {
        return PopNavigationAction(screenKind: screenType, animated: animated, completion: completion)
    }
}
