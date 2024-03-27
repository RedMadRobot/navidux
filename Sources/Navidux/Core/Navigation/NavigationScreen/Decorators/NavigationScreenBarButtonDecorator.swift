//
//  NavigationScreenBarButtonDecorator.swift
//
//
//  Created by Tamerlan Satualdypov on 19.03.2024.
//

import UIKit

public struct NavigationScreenBarButtonDecorator<Screen: UIViewController>: NavigationScreenDecorator {
    public enum Position {
        case left
        case right
    }
    
    private let items: [UIBarButtonItem]
    private let position: Position
    
    init(items: [UIBarButtonItem], position: Position) {
        self.items = items
        self.position = position
    }
    
    init(item: UIBarButtonItem, position: Position) {
        self.init(items: [item], position: position)
    }
    
    public func decorate(screen: Screen) -> Screen {
        switch self.position {
        case .left:
            screen.navigationItem.leftBarButtonItems = self.items
        case .right:
            screen.navigationItem.rightBarButtonItems = self.items
        }
        
        return screen
    }
}

public extension Module where Screen: UIViewController {
    func barButton(_ item: UIBarButtonItem, at position: NavigationScreenBarButtonDecorator<Screen>.Position) -> any Module {
        return self.decorated(by: NavigationScreenBarButtonDecorator<Screen>(item: item, position: position))
    }
    
    func barButtons(_ items: [UIBarButtonItem], at position: NavigationScreenBarButtonDecorator<Screen>.Position) -> any Module {
        return self.decorated(by: NavigationScreenBarButtonDecorator<Screen>(items: items, position: position))
    }
}
