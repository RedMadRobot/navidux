//
//  PushNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import Foundation

public struct PushNavigationAction: NavigationAction {
    private let module: any Module
    private let animated: Bool
    private let completion: (() -> Void)?
    
    init(module: any Module, animated: Bool, completion: (() -> Void)?) {
        self.module = module
        self.animated = animated
        self.completion = completion
    }
    
    public func perform(on coordinator: Coordinator) {
        let screen = self.module.assembly(using: coordinator)
        coordinator.navigationController.push(screen: screen, animated: self.animated, completion: self.completion)
    }
}

public extension NavigationAction where Self == PushNavigationAction {
    static func push(_ module: any Module, animated: Bool = true, completion: (() -> Void)?) -> Self {
        return PushNavigationAction(module: module, animated: animated, completion: completion)
    }
}
