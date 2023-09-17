import SwiftUI
import UIKit

open class HostingController<ViewContent: View>: UIHostingController<ViewContent>,
                                                  NavigationScreen,
                                                  DismissCheckable,
                                                  UIGestureRecognizerDelegate {
    public var tag: String
    public var isModal: Bool = false
    var isNeedBackButton: Bool
    public weak var navigation: (any Router)?
    public var navigationCallback: (() -> Void)? = nil
    public var onBackCallback: () -> Void
    open func gotUpdatedData(_ payload: NullablePayload) {
        print("got data from top screen: \(payload.debugDescription)")
    }
    
    @objc func onBack() {
        onBackCallback()
    }
    
    // MARK: - Init
    
    public init(
        navTitle: String,
        setBackButton: Bool = false,
        tag: String,
        navigation: (any Router)? = nil,
        content: ViewContent
    ) {
        self.tag = tag
        self.isNeedBackButton = setBackButton
        self.navigation = navigation
        onBackCallback = { [weak navigation] in
            navigation?.route(with: .pop(nil))
        }
        super.init(rootView: content)
        title = navTitle
    }
    
    @available(*, deprecated, message: "use init with params instead.")
    public required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        if isNeedBackButton {
            configureNavigationBackButton(#selector(onBack))
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cleanBackNavigationButton()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed || isMovingFromParent {
            navigationCallback?()
        }
    }
    
    // MARK: - DismissCheckable
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer)
        else {
            return true
        }
        
        onBack()
        
        return false
    }
}
