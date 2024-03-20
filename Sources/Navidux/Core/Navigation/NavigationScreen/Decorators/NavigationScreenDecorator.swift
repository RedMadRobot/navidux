//
//  NavigationScreenDecorator.swift
//
//
//  Created by Tamerlan Satualdypov on 19.03.2024.
//

import Foundation

public protocol NavigationScreenDecorator {
    associatedtype Screen: NavigationScreen
    
    func decorate(screen: Screen) -> Screen
}

struct DecoratedModule<Wrapped: Module, Decorator: NavigationScreenDecorator>: Module where Decorator.Screen == Wrapped.Screen {
    private let module: Wrapped
    private let decorator: Decorator
    
    init(module: Wrapped, decorator: Decorator) {
        self.module = module
        self.decorator = decorator
    }
    
    func assembly(using coordinator: Coordinator) -> Wrapped.Screen {
        return self.decorator.decorate(screen: self.module.assembly(using: coordinator))
    }
}

public extension Module {
    func decorated<Decorator: NavigationScreenDecorator>(by decorator: Decorator) -> any Module where Decorator.Screen == Self.Screen {
        return DecoratedModule(module: self, decorator: decorator)
    }
}
