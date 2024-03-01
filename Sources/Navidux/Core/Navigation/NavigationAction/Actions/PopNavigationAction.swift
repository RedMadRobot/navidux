//
//  PopNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import UIKit

public struct PopNavigationAction: NavigationAction {
    private let screenClass: UIViewController.Type?
    private let animated: Bool
    
    init(screenClass: UIViewController.Type?, animated: Bool) {
        self.screenClass = screenClass
        self.animated = animated
    }
    
    public func perform(on coordinator: Coordinator) {
        guard
            let screenClass,
            let screen = coordinator.navigationController.screens.last(where: { $0.isKind(of: screenClass) })
        else {
            if coordinator.store.hasOverlay {
                coordinator.store.hasOverlay = false
                coordinator.navigationController.dismiss(animated: self.animated, completion: nil)
            } else {
                coordinator.navigationController.popViewController(animated: self.animated)
            }
            return
        }
        
        coordinator.navigationController.popToViewController(screen, animated: self.animated)
    }
}

public extension NavigationAction where Self == PopNavigationAction {
    static var pop: Self {
        PopNavigationAction(screenClass: nil, animated: true)
    }
    
    static func pop(animated: Bool) -> Self {
        PopNavigationAction(screenClass: nil, animated: animated)
    }
    
    static func popTo(_ screenClass: UIViewController.Type, animated: Bool = true) -> Self {
        PopNavigationAction(screenClass: screenClass, animated: animated)
    }
}
