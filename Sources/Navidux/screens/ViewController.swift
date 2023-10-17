import UIKit

open class ViewController: UIViewController,
                           NavigationScreen,
                           DismissCheckable,
                           UIGestureRecognizerDelegate {
    
    // MARK: - Public properties
    
    public var tag: String
    public var isModal: Bool = false
    public weak var navigation: (any Router)?
    public var navigationCallback: (() -> Void)? = nil
    public var onBackCallback: () -> Void
    public var backButtonImage: UIImage? = UIImage(systemName: "chevron.backward")
    public var isNeedBackButton: Bool
    open var dataToSendFromModal: NullablePayload = nil
    public var output: ((NullablePayload) -> Void)
    
    // MARK: - Init
    
    public init(
        title: String = "",
        isNeedBackButton: Bool = true,
        navigation: (any Router)? = nil,
        tag: String = UUID().uuidString,
        output: @escaping (NullablePayload) -> Void = { _ in }
    ) {
        self.navigation = navigation
        self.tag = tag
        self.isNeedBackButton = isNeedBackButton
        self.onBackCallback = { [weak navigation] in
            navigation?.route(with: .pop(nil))
        }
        self.output = output
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    @available(*, deprecated, message: "use init() instead.")
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedBackButton {
            configureNavigationBackButton(#selector(onBack))
        } else {
            navigationItem.hidesBackButton = true
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isNeedBackButton {
            cleanBackNavigationButton()
        }
    }
    
    
    // MARK: - Public methods
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer)
        else {
            return true
        }
        
        onBack()
        
        return false
    }
    
    @objc
    public func onBack() {
        onBackCallback()
    }
    
    open func gotUpdatedData(_ payload: NullablePayload) {
        //HINT: Do some action on getted response from previous screen
        debugPrint("Screen recieved data: \(String(describing: payload))")
    }
}
