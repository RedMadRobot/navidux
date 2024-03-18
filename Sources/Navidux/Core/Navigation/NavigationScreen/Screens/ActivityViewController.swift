//
//  ActivityViewController.swift
//  Navidux
//
//  Created by Stanislav Anatskii on 20.12.2022.
//  Copyright © 2022 red_mad_robot. All rights reserved.
//

import UIKit

public final class ActivityViewController: UIActivityViewController, NavigationScreenOld {
    
    // MARK: - Public properties
    
    public var tag: String
    public var isModal: Bool = true
    public var navigationCallback: (() -> Void)?
    public var onBackCallback: () -> Void
    public var dataToSendFromModal: NullablePayload
    public var output: ((NullablePayload) -> Void)
    
    // MARK: - Init
    
    public init(
        activityItems: [Any],
        applicationActivities: [UIActivity]?,
        tag: String = UUID().uuidString,
        output: @escaping (NullablePayload) -> Void
    ) {
        onBackCallback = { }
        self.output = output
        self.tag = tag
        self.dataToSendFromModal = nil

        super.init(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
    }

    // MARK: - Lifecycle
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationCallback?()
    }
    
    // MARK: - Public methods
    
    public func gotUpdatedData(_ payload: NullablePayload) {}
}
