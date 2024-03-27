import UIKit

public protocol NavigationScreen: UIViewController, Equatable {
    var id: String { get }
    var presentationStyle: PresentationStyle { get set }
}

public extension NavigationScreen {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension UIViewController: NavigationScreen {
    private static var vars: [String: Any] = [:]
    
    public var id: String {
        return "\(String(describing: Self.self)) \(self.hashValue)"
    }
    
    public var presentationStyle: PresentationStyle {
        get {
            return (Self.vars["presentationStyle"] as? PresentationStyle) ?? .fullScreen
        }
        
        set {
            Self.vars["presentationStyle"] = newValue
        }
    }
}
