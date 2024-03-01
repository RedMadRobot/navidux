//
//  NavigationStore.swift
//
//
//  Created by Петр Тартынских on 01.03.2024.
//

public struct NavigationStore {
    public var isAlertShow: Bool = false
    public var hasOverlay: Bool = false
    
    public init(isAlertShow: Bool = false, hasOverlay: Bool = false) {
        self.isAlertShow = isAlertShow
        self.hasOverlay = hasOverlay
    }
}
