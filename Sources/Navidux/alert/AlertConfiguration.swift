import UIKit

public struct AlertConfiguration: Equatable {
    public struct ButtonAction: Equatable {
        let title: String
        let style: ButtonStyle
        let action: () -> Void
        
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.title == rhs.title && lhs.style == rhs.style
        }
    }
    
    public enum ButtonStyle: Equatable {
        case `default`
        case cancel
        case destructive
    }
    
    public enum PresentationStyle: Equatable {
        case actionSheet
        case center
    }
    
    let title: String
    let message: String
    let style: PresentationStyle
    let actions: [ButtonAction]
}

extension AlertConfiguration.ButtonStyle {
    var asUIAlertActionStyle: UIAlertAction.Style {
        switch self {
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        case .default:
            return .default
        }
    }
}
