import UIKit

open class ViewController: UIViewController,
                           NavigationScreen,
                           DismissCheckable,
                           UIGestureRecognizerDelegate {
    
    // MARK: - Public properties
    
    public var tag: String
    public var isModal: Bool = false
    public weak var coordinator: Coordinator?
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
        coordinator: Coordinator? = nil,
        tag: String = String(describing: ViewController.self) + UUID().uuidString,
        output: @escaping (NullablePayload) -> Void = { _ in }
    ) {
        self.coordinator = coordinator
        self.tag = tag
        self.isNeedBackButton = isNeedBackButton
        self.onBackCallback = { [weak coordinator] in
            coordinator?.perform(action: .pop)
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
