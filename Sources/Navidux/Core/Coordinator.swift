//
//  Coordinator.swift
//
//
//  Created by Tamerlan Satualdypov on 12.02.2024.
//

import Foundation

public final class Coordinator {
    public var navigationController: NavigationController
    public var dependencyContainer: DependencyContainer
    
    public init(navigationController: NavigationController? = nil) {
        self.navigationController = navigationController ?? BaseNavigationController()
        self.dependencyContainer = DependencyContainer()
    }
    
    public func perform(action: NavigationAction) {
        action.perform(on: self)
    }
}
