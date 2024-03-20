//
//  RestructNavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 19.02.2024.
//

import UIKit

public struct RestructNavigationAction: NavigationAction {
    private let modules: [any Module]
    
    init(modules: [any Module]) {
        self.modules = modules
    }
    
    public func perform(on coordinator: Coordinator) {
        let screenStack = self.modules.map { $0.assembly(using: coordinator) }
        coordinator.navigationController.set(stack: screenStack)
    }
}

public extension NavigationAction where Self == RestructNavigationAction {
    static func restruct(with modules: [any Module]) -> Self {
        return RestructNavigationAction(modules: modules)
    }
}
