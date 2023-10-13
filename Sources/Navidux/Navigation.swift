import UIKit
import SwiftUI

public enum Navigation: Equatable {
    /// PresentationStyle uses to choose correct form of pushing your screen.
    /// - Note:
    /// + fullscren - its normal presentation like `UINavigationController.push(...)` without additional settings.
    /// + modal - its modal presentation like `UINavigationController.present(...)` without additional settings.
    /// + bottomSheet - its modal presentation of the screen from bottom part with simple animation.
    /// + custom - its fully customisable animation for `UINavigationController.push(...)` with your own parameters. *WORK IN PROGRESS*
    public enum PresentationStyle {
        case fullscreen
        case modal
        case bottomSheet([BottomSheetSize], scrollView: UIScrollView?)
        case custom(UIViewControllerTransitioningDelegate)
    }

    public enum BottomSheetSize {
        case fixed(CGFloat)
        case halfScreen
        case fullScreen
        case auto
    }

    public enum RestructActionAnimation {
        case forward
        case backward
    }
    
    public enum Action {
        case push(NaviduxScreen, ScreenConfig, PresentationStyle)
        case pop(NullablePayload)
        case popUntil(NaviduxScreen, NullablePayload)
        case restruct(screens: [NavigationRestructable], animationType: RestructActionAnimation)
        case replaceCurrent(NaviduxScreen, ScreenConfig, RestructActionAnimation)
        case showAlert(AlertConfiguration)
    }
}

public protocol NavigationRestructable {}
