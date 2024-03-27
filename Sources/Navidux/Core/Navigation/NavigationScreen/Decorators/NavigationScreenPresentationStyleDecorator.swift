//
//  NavigationScreenPresentationStyleDecorator.swift
//
//
//  Created by Tamerlan Satualdypov on 26.03.2024.
//

import UIKit

public struct NavigationScreenPresentationStyleDecorator<Screen: UIViewController>: NavigationScreenDecorator {
    private let presentationStyle: PresentationStyle
    
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
    
    public func decorate(screen: Screen) -> Screen {
        screen.presentationStyle = self.presentationStyle
        return screen
    }
}

public extension Module {
    func presentationStyle(_ presentationStyle: PresentationStyle) -> any Module {
        return self.decorated(by: NavigationScreenPresentationStyleDecorator(presentationStyle: presentationStyle))
    }
}
