import UIKit

open class ViewController: UIViewController, NavigationScreen, DismissCheckable, UIGestureRecognizerDelegate {
    public var tag: String
    public var isModal: Bool = false
    public var navigationCallback: (() -> Void)? = nil
    public var navigation: (any Router)?
    public var onBackCallback: () -> Void
    open func gotUpdatedData(_ payload: NullablePayload) {}
    @objc func onBack() {
        onBackCallback()
    }
    
    // MARK: - Lifecycle
    
    public init(navigation: (any Router)?, tag: String = UUID().uuidString) {
        onBackCallback = { [weak navigation] in
            navigation?.route(with: .pop(nil))
        }
        self.navigation = navigation
        self.tag = tag
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, deprecated, message: "use init() instead.")
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        configureNavigationBackButton(#selector(onBack))
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cleanBackNavigationButton()
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
