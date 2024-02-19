//
//  Module.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import UIKit

public protocol Module {
    func assembly(using coordinator: Coordinator) -> any NavigationScreen
}
