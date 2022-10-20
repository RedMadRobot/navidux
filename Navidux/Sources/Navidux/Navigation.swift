import UIKit
import SwiftUI

public enum Navigation: Equatable {
    public enum Screen: Equatable {
        case firstScreen
        case secondScreen
        
        var asScreenClass: UIViewController.Type {
            switch self {
            case .firstScreen:
                return UIViewController.self
            case .secondScreen:
                return UIViewController.self
            }
        }
    }
    
    public enum PresentationStyle {
        case fullscreen
        case modal
        case bottomSheet([BottomSheetSize])
        case custom(UIViewControllerTransitioningDelegate)
    }
    
    public enum BottomSheetSize {
        //TODO: Flexible bottom sheet на подумать
        case fixed(CGFloat)
        case halfScreen
        case fullScreen
    }

    public enum Action {
        case start(ScreenConfig)
        case push(Screen, ScreenConfig, PresentationStyle)
        case pop(NullablePayload)
        case popUntil(Screen, NullablePayload)
        case restruct([(Screen, ScreenConfig)])
        case showAlert(AlertConfiguration)
    }
}
