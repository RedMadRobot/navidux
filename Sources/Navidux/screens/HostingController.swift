import SwiftUI
import UIKit

final class HostingController<ViewContent: View>: UIHostingController<ViewContent>,
                                                  NavigationScreen,
                                                  DismissCheckable,
                                                  UIGestureRecognizerDelegate {
    
    // MARK: - Public properties
    
    var tag: String
    var isModal: Bool = false
    weak var navigation: (any Router)?
    var navigationCallback: (() -> Void)? = nil
    var onBackCallback: () -> Void
    var backButtonImage: UIImage? = UIImage(systemName: "chevron.backward")
    var isNeedBackButton: Bool
    var dataToSendFromModal: NullablePayload = nil
    var output: (NullablePayload) -> Void
    
    // MARK: - Init
    
    init(
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
    
    @available(*, deprecated, message: "use init() instead.")
    required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedBackButton {
            configureNavigationBackButton(#selector(onBack))
        } else {
            navigationItem.hidesBackButton = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isNeedBackButton {
            cleanBackNavigationButton()
        }
    }
    
    // MARK: - Public methods
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer)
        else {
            return true
        }
        
        onBack()
        
        return false
    }
    
    @objc
    func onBack() {
        onBackCallback()
    }
    
    // TODO: - Подумать как использовать
    func gotUpdatedData(_ payload: NullablePayload) {}
}
