//
//  NavigationCoordinatorProxy.swift
//  
//
//  Created by Александр Евсеев on 20.10.2022.
//

public final class NavigationCoordinatorProxy: Coordinator {
    public var subject: Coordinator!

    public init(subject: Coordinator? = nil) {
        self.subject = subject
    }

    public func actionReducer(action: Navigation.Action) {
        subject.actionReducer(action: action)
    }

    public func start() {
        subject.start()
    }
}
