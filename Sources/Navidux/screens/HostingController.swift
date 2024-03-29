import SwiftUI
import UIKit

public final class HostingController<ViewContent: View>: UIHostingController<ViewContent>,
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
    public var dataToSendFromModal: NullablePayload = nil
    public var output: (NullablePayload) -> Void
    
    // MARK: - Init
    
    public init(
        title: String,
        isNeedBackButton: Bool,
        tag: String,
        navigation: (any Router)?,
        content: ViewContent,
        output: @escaping (NullablePayload) -> Void = { _ in }
    ) {
        self.tag = tag
        self.navigation = navigation
        self.isNeedBackButton = isNeedBackButton
        self.onBackCallback = { [weak navigation] in
            navigation?.route(with: .pop(nil))
        }
        self.output = output
        super.init(rootView: content)
        self.title = title
    }
    
    @available(*, deprecated, message: "use init with params instead.")
    public required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedBackButton {
            configureNavigationBackButton(#selector(onBack))
        } else {
            navigationItem.hidesBackButton = true
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    public override func viewDidDisappear(_ animated: Bool) {
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
    
    // TODO: - Подумать как использовать
    public func gotUpdatedData(_ payload: NullablePayload) {}
}
