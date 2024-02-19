//
//  File.swift
//  
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import Foundation

public protocol RoutingAction {
    func perform(on coordinator: Coordinator)
}
