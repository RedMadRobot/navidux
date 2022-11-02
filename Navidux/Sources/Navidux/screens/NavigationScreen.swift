import UIKit

/// Main element of Navigation on Redux (Navidux). Uses for store/move screens in navigation stack.
public protocol NavigationScreen: UIViewController, AnyObject where Self: Equatable {
    /// - **tag**: The unique tag of the screen. Use for search in nav stack. Can be set on screen setup.
    var tag: String { get set }
    /// - **isModal**: property indicates that screen will be present as modal or not. Edited only from NavigationRouter.
    var isModal: Bool { get set }
    /// - **navigationCallback**: used for additional checking in navigation core and support consistency of the navigation state. Edited only from NavigationRouter.
    var navigationCallback: (() -> Void)? { get set }
    /// - **onBackCallback**: function that fired then user use back button or swipe. Can be set on screen setup.
    var onBackCallback: () -> Void { get set }
    /// - **gotUpdatedData**: function that fired on then upper screen remove from nav stack and current screen become topScreen. Can be overrided.
    func gotUpdatedData(_ payload: NullablePayload)
}

extension NavigationScreen {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tag == rhs.tag
    }
}

protocol DismissCheckable {
    func configureNavigationBackButton(_ selector: Selector)
    func cleanBackNavigationButton()
    func onBack()
}

extension DismissCheckable where Self: UIViewController {
    
    func configureNavigationBackButton(_ selector: Selector) {
        navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: selector)
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    func cleanBackNavigationButton() {
        guard navigationController?.viewControllers.first === self else {
            return
        }
        navigationItem.leftBarButtonItem = nil
    }
}
