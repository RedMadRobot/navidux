//
//  PopNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import UIKit

public struct PopNavigationAction: NavigationAction {
    private let screenClass: UIViewController.Type?
    
    init(screenClass: UIViewController.Type?) {
        self.screenClass = screenClass
    }
    
    public func perform(on coordinator: Coordinator) {
        guard
            let screenClass = self.screenClass,
            let screen = coordinator.navigationController.screens.last(where: { $0.isKind(of: screenClass) })
        else {
            coordinator.navigationController.popViewController(animated: true)
            return
        }
        
        coordinator.navigationController.popToViewController(screen, animated: true)
    }
}

public extension NavigationAction where Self == PopNavigationAction {
    static var pop: Self {
        return .init(screenClass: nil)
    }
    
    static func popTo(_ screenClass: UIViewController.Type) -> Self {
        return .init(screenClass: screenClass)
    }
}
