//
//  Module.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import UIKit

public protocol Module {
    associatedtype Screen: NavigationScreen
    
    func assembly(using coordinator: Coordinator) -> Screen
}
