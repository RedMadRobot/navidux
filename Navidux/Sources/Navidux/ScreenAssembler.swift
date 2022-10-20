//
//  ScreenAssembler.swift
//  
//
//  Created by Александр Евсеев on 20.10.2022.
//

public protocol ScreenAssembler {
    func assemblyScreen(screenType: Navigation.Screen, config: ScreenConfig) -> any NavigationScreen
    func assemblyAlert(configuration: AlertConfiguration) -> AlertScreen
}
