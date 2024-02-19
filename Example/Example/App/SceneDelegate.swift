import Navidux
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var coordinator: Coordinator!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let navigation = DefaultNavigationController { controller in
            controller.view.backgroundColor = .green
            controller.navigationBar.isTranslucent = false
            controller.navigationBar.backgroundColor = .green
            controller.navigationBar.shadowImage = .init()
            controller.navigationBar.barTintColor = .green
            controller.navigationBar.tintColor = .black
            controller.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
        coordinator = .init(navigationController: navigation)
        coordinator.perform(action: .push(.first, as: .fullScreen))
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

