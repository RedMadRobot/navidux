//
//  DependencyContainer.swift
//
//
//  Created by Tamerlan Satualdypov on 13.02.2024.
//

import Foundation

public final class DependencyContainer {
    private var values: [String: Any] = [:]
    
    func register<T>(_ type: T.Type, builder: @escaping () -> T) {
        self.values["\(type)"] = builder()
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return self.values["\(type)"] as? T
    }
}
