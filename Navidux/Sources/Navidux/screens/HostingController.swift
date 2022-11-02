import SwiftUI
import UIKit

final class HostingController<ViewContent: View>: UIHostingController<ViewContent>,
                                                  DismissCheckable,
                                                  UIGestureRecognizerDelegate {
    var tag: String
    var isModal: Bool = false
    var isNeedBackButton: Bool
    weak var navigation: (any Coordinator)?
    var navigationCallback: (() -> Void)? = nil
    var onBackCallback: () -> Void
    
    @objc func onBack() {
        onBackCallback()
    }
    
    // MARK: - Init
    
    init(navTitle: String, setBackButton: Bool, tag: String, navigation: (any Coordinator)?, content: ViewContent) {
        self.tag = tag
        self.isNeedBackButton = setBackButton
        self.navigation = navigation
        onBackCallback = { [weak navigation] in
            navigation?.actionReducer(action: .pop(nil))
        }
        super.init(rootView: content)
        title = navTitle
    }
    
    @available(*, deprecated, message: "use init() instead.")
    required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        if isNeedBackButton {
            configureNavigationBackButton(#selector(onBack))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        cleanBackNavigationButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed || isMovingFromParent {
            navigationCallback?()
        }
    }
    
    // MARK: - DismissCheckable
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard
            gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer)
        else {
            return true
        }
        
        onBack()
        
        return false
    }
}

extension HostingController: NavigationScreen {
    func gotUpdatedData(_ payload: NullablePayload) {
        //HINT: Do some action on getted response from previous screen
        debugPrint("Screen recieved data: \(payload)")
    }
}
