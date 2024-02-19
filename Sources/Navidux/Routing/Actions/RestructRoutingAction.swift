//
//  File.swift
//  
//
//  Created by Tamerlan Satualdypov on 19.02.2024.
//

import UIKit

public struct RestructRoutingAction: RoutingAction {
    public enum AnimationType {
        case forward
        case backward
    }
    
    private let modules: [Module]
    private let animationType: AnimationType
    
    init(modules: [Module], animationType: AnimationType) {
        self.modules = modules
        self.animationType = animationType
    }
    
    public func perform(on coordinator: Coordinator) {
        let stack = self.modules.map { $0.assembly(using: coordinator) as UIViewController }
        
        switch self.animationType {
        case .forward:
            self.updateForward(stack: stack, coordinator: coordinator)
        case .backward:
            self.updateBackward(stack: stack, coordinator: coordinator)
        }
    }
    
    private func updateForward(stack: [UIViewController], coordinator: Coordinator) {
        coordinator.navigationController.setViewControllers(stack, animated: true)
    }
    
    private func updateBackward(stack: [UIViewController], coordinator: Coordinator) {
        coordinator.navigationController.viewControllers = stack
        coordinator.navigationController.popViewController(animated: true)
    }
}

public extension RoutingAction where Self == RestructRoutingAction {
    static func restruct(with modules: [Module], animation: RestructRoutingAction.AnimationType) -> Self {
        return .init(modules: modules, animationType: animation)
    }
}
