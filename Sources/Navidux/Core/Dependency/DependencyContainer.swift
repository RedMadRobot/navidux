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
    
    func resolve<T>(_ type: T.Type) -> T {
        guard let value = self.values["\(type)"] as? T else {
            fatalError("[Navidux]: \(String(describing: type)) not registered in the DependencyContainer!")
        }
        
        return value
    }
}
