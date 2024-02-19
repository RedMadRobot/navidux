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
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = DefaultNavigationController()
        }
        
        self.dependencyContainer = .init()
    }
    
    public func perform(action: NavigationAction) {
        action.perform(on: self)
    }
}
