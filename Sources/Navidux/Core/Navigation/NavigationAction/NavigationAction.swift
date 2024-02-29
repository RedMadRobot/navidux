//
//  NavigationAction.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import Foundation

public protocol NavigationAction {
    func perform(on coordinator: Coordinator)
}
