//
//  Coordinator.swift
//
//
//  Created by Tamerlan Satualdypov on 12.02.2024.
//

import Foundation

public final class Coordinator {
    let bottomSheetTransitioningDelegate = BSTransitioningDelegate()
    
    public var navigationController: NavigationController
    public var dependencyContainer: DependencyContainer
    public var store: NavigationStore
    
    public init(navigationController: NavigationController? = nil) {
        self.navigationController = navigationController ?? BaseNavigationController()
        self.dependencyContainer = DependencyContainer()
        self.store = NavigationStore()
    }
    
    public func perform(action: NavigationAction) {
        action.perform(on: self)
    }
}
